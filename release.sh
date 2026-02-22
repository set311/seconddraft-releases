#!/bin/bash
#
# Second Draft — Release Script
#
# Builds, signs, notarizes, and publishes a new release.
#
# Usage:
#   ./release.sh
#
# Prerequisites:
#   - Xcode with Developer ID Application certificate
#   - Notarization credentials stored: xcrun notarytool store-credentials "SecondDraft"
#   - Sparkle EdDSA keys in Keychain
#   - GitHub SSH access configured for set311/seconddraft-releases
#   - gh CLI authenticated: gh auth login
#
# What this script does:
#   1.  Reads version info from the Xcode project
#   2.  Archives with Release configuration + Developer ID signing
#   3.  Exports the archive
#   4.  Notarizes with Apple
#   5.  Staples the notarization ticket
#   6.  Creates a DMG
#   7.  Signs the DMG for Sparkle (EdDSA)
#   8.  Generates/updates appcast.xml
#   9.  Updates landing page download buttons with new version
#   10. Pushes to GitHub + creates GitHub Release via gh CLI
#   11. Verifies everything is live
#

set -e  # Exit on any error

# ─────────────────────────────────────────────────────────────
# Configuration
# ─────────────────────────────────────────────────────────────

PROJECT_DIR="$HOME/EnglishCoach"
PROJECT_FILE="$PROJECT_DIR/EnglishCoach.xcodeproj"
SCHEME="EnglishCoach"
RELEASES_DIR="$HOME/Documents/Builds/seconddraft-releases"
LANDING_DIR="$RELEASES_DIR/landing"
SPARKLE_BIN="$HOME/Library/Developer/Xcode/DerivedData/EnglishCoach-gosgwlmtclbucohimsneotlswfxb/SourcePackages/artifacts/sparkle/Sparkle/bin"
NOTARY_PROFILE="SecondDraft"
GITHUB_REPO="set311/seconddraft-releases"
APPCAST_URL="https://set311.github.io/seconddraft-releases/appcast.xml"
LANDING_URL="https://set311.github.io/seconddraft-releases/"
DOWNLOAD_BASE_URL="https://github.com/set311/seconddraft-releases/releases/download"

# Temporary build directory (cleaned up at the end)
BUILD_DIR="$RELEASES_DIR/build-temp"

# App name as it comes out of Xcode
APP_NAME="SecondDraft.app"

# Ensure Homebrew binaries are in PATH (for gh CLI)
export PATH="/opt/homebrew/bin:$PATH"

# ─────────────────────────────────────────────────────────────
# Helper functions
# ─────────────────────────────────────────────────────────────

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

step() {
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  STEP $1: $2${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
}

success() {
    echo -e "${GREEN}  ✅ $1${NC}"
}

warn() {
    echo -e "${YELLOW}  ⚠️  $1${NC}"
}

fail() {
    echo -e "${RED}  ❌ $1${NC}"
    exit 1
}

info() {
    echo -e "  ℹ️  $1"
}

# ─────────────────────────────────────────────────────────────
# Pre-flight checks
# ─────────────────────────────────────────────────────────────

step "0" "Pre-flight checks"

# Check project exists
if [ ! -d "$PROJECT_FILE" ]; then
    fail "Xcode project not found at $PROJECT_FILE"
fi

# Check Sparkle tools exist
if [ ! -f "$SPARKLE_BIN/sign_update" ]; then
    fail "Sparkle tools not found at $SPARKLE_BIN. Build the project in Xcode first to download SPM packages."
fi

# Check notarization credentials
xcrun notarytool history --keychain-profile "$NOTARY_PROFILE" > /dev/null 2>&1 || \
    fail "Notarization credentials not found. Run: xcrun notarytool store-credentials \"$NOTARY_PROFILE\""

# Check Developer ID certificate
if ! security find-identity -v -p codesigning | grep -q "Developer ID Application"; then
    fail "Developer ID Application certificate not found in Keychain."
fi

# Check releases repo
if [ ! -d "$RELEASES_DIR/.git" ]; then
    fail "Releases repo not found at $RELEASES_DIR"
fi

# Check gh CLI
if ! command -v gh &> /dev/null; then
    fail "gh CLI not found. Install with: brew install gh"
fi

# Check gh auth
if ! gh auth status &> /dev/null; then
    fail "gh CLI not authenticated. Run: gh auth login"
fi

# Check landing page source exists
if [ ! -f "$LANDING_DIR/index.html" ]; then
    fail "Landing page not found at $LANDING_DIR/index.html"
fi

success "All pre-flight checks passed"

# ─────────────────────────────────────────────────────────────
# Read version from project
# ─────────────────────────────────────────────────────────────

step "1" "Reading version info from Xcode project"

# Read all build settings once (faster than calling xcodebuild 3 times)
BUILD_SETTINGS=$(xcodebuild -project "$PROJECT_FILE" -scheme "$SCHEME" -configuration Release -showBuildSettings 2>/dev/null)

MARKETING_VERSION=$(echo "$BUILD_SETTINGS" | grep "MARKETING_VERSION" | head -1 | awk '{print $3}')
BUILD_NUMBER=$(echo "$BUILD_SETTINGS" | grep "CURRENT_PROJECT_VERSION" | head -1 | awk '{print $3}')
BUNDLE_ID=$(echo "$BUILD_SETTINGS" | grep "PRODUCT_BUNDLE_IDENTIFIER" | head -1 | awk '{print $3}')

if [ -z "$MARKETING_VERSION" ] || [ -z "$BUILD_NUMBER" ]; then
    fail "Could not read version info from project."
fi

DMG_NAME="SecondDraft-${MARKETING_VERSION}.dmg"
TAG_NAME="v${MARKETING_VERSION}"
DOWNLOAD_URL="${DOWNLOAD_BASE_URL}/${TAG_NAME}/${DMG_NAME}"

info "Version:      $MARKETING_VERSION"
info "Build:        $BUILD_NUMBER"
info "Bundle ID:    $BUNDLE_ID"
info "DMG name:     $DMG_NAME"
info "Git tag:      $TAG_NAME"
info "Download URL: $DOWNLOAD_URL"

# Check if this tag already exists on GitHub
if gh release view "$TAG_NAME" --repo "$GITHUB_REPO" &> /dev/null; then
    warn "GitHub Release $TAG_NAME already exists!"
    read -p "  Delete existing release and re-create? (y/N): " OVERWRITE
    if [ "$OVERWRITE" != "y" ] && [ "$OVERWRITE" != "Y" ]; then
        fail "Aborted. Increment your version numbers in Xcode first."
    fi
    info "Will delete existing release $TAG_NAME before creating new one."
    DELETE_EXISTING_RELEASE=true
fi

echo ""
echo -e "${YELLOW}  Ready to build and release Second Draft v${MARKETING_VERSION} (build ${BUILD_NUMBER})${NC}"
echo ""
echo "  This will:"
echo "    1. Archive with Release config + Developer ID signing"
echo "    2. Notarize with Apple"
echo "    3. Create DMG + sign for Sparkle"
echo "    4. Update landing page download button → v${MARKETING_VERSION}"
echo "    5. Push appcast.xml + landing page to GitHub"
echo "    6. Create GitHub Release with DMG"
echo ""
read -p "  Continue? (y/N): " CONFIRM
if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
    echo "  Aborted."
    exit 0
fi

# ─────────────────────────────────────────────────────────────
# Clean and archive
# ─────────────────────────────────────────────────────────────

step "2" "Archiving (Release configuration, Developer ID signing)"

# Clean build temp
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

ARCHIVE_PATH="$BUILD_DIR/SecondDraft.xcarchive"

info "Building... (this may take a minute)"

xcodebuild archive \
    -project "$PROJECT_FILE" \
    -scheme "$SCHEME" \
    -configuration Release \
    -archivePath "$ARCHIVE_PATH" \
    CODE_SIGN_IDENTITY="Developer ID Application" \
    DEVELOPMENT_TEAM="SGV2XEF85M" \
    CODE_SIGN_STYLE="Manual" \
    OTHER_CODE_SIGN_FLAGS="--timestamp" \
    2>&1 | tail -5

if [ ! -d "$ARCHIVE_PATH" ]; then
    fail "Archive failed. Check Xcode build errors."
fi

success "Archive created"

# ─────────────────────────────────────────────────────────────
# Export the archive
# ─────────────────────────────────────────────────────────────

step "3" "Exporting with Developer ID signing"

EXPORT_DIR="$BUILD_DIR/export"
EXPORT_OPTIONS="$BUILD_DIR/ExportOptions.plist"

# Create export options plist
cat > "$EXPORT_OPTIONS" << 'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>
    <string>developer-id</string>
    <key>teamID</key>
    <string>SGV2XEF85M</string>
    <key>signingStyle</key>
    <string>manual</string>
    <key>signingCertificate</key>
    <string>Developer ID Application</string>
</dict>
</plist>
PLIST

xcodebuild -exportArchive \
    -archivePath "$ARCHIVE_PATH" \
    -exportPath "$EXPORT_DIR" \
    -exportOptionsPlist "$EXPORT_OPTIONS" \
    2>&1 | tail -5

APP_PATH="$EXPORT_DIR/$APP_NAME"

if [ ! -d "$APP_PATH" ]; then
    fail "Export failed. App not found at $APP_PATH"
fi

success "App exported to $APP_PATH"

# Verify it's signed with Developer ID (not Apple Development)
SIGN_INFO=$(codesign -dvv "$APP_PATH" 2>&1 | grep "Authority=Developer ID" || true)
if [ -z "$SIGN_INFO" ]; then
    warn "App may not be signed with Developer ID. Checking..."
    codesign -dvv "$APP_PATH" 2>&1 | grep "Authority"
    fail "App is NOT signed with Developer ID Application. Check your certificate."
fi

success "Verified: signed with Developer ID Application"

# ─────────────────────────────────────────────────────────────
# Notarize
# ─────────────────────────────────────────────────────────────

step "4" "Notarizing with Apple (this may take a few minutes)"

NOTARIZE_ZIP="$BUILD_DIR/notarize-upload.zip"

# Create ZIP for notarization using ditto (preserves symlinks!)
ditto -c -k --sequesterRsrc --keepParent "$APP_PATH" "$NOTARIZE_ZIP"

info "Submitting to Apple notary service..."

NOTARIZE_OUTPUT=$(xcrun notarytool submit "$NOTARIZE_ZIP" \
    --keychain-profile "$NOTARY_PROFILE" \
    --wait \
    2>&1)

echo "$NOTARIZE_OUTPUT"

if echo "$NOTARIZE_OUTPUT" | grep -q "status: Accepted"; then
    success "Notarization accepted!"
elif echo "$NOTARIZE_OUTPUT" | grep -q "status: Invalid"; then
    # Get the submission ID and fetch the log
    SUBMISSION_ID=$(echo "$NOTARIZE_OUTPUT" | grep "id:" | head -1 | awk '{print $2}')
    warn "Notarization REJECTED. Fetching log..."
    xcrun notarytool log "$SUBMISSION_ID" --keychain-profile "$NOTARY_PROFILE" 2>&1
    fail "Notarization failed. See log above."
else
    fail "Unexpected notarization result. See output above."
fi

# ─────────────────────────────────────────────────────────────
# Staple
# ─────────────────────────────────────────────────────────────

step "5" "Stapling notarization ticket"

xcrun stapler staple "$APP_PATH"

# Verify with spctl
SPCTL_OUTPUT=$(spctl -a -vv "$APP_PATH" 2>&1)
echo "$SPCTL_OUTPUT"

if echo "$SPCTL_OUTPUT" | grep -q "Notarized Developer ID"; then
    success "Verified: Notarized Developer ID"
elif echo "$SPCTL_OUTPUT" | grep -q "accepted"; then
    success "Verified: accepted by Gatekeeper"
else
    fail "spctl verification failed. See output above."
fi

# ─────────────────────────────────────────────────────────────
# Create DMG
# ─────────────────────────────────────────────────────────────

step "6" "Creating DMG"

DMG_PATH="$RELEASES_DIR/$DMG_NAME"

# Remove old DMG if it exists
rm -f "$DMG_PATH"

hdiutil create \
    -volname "Second Draft" \
    -srcfolder "$APP_PATH" \
    -ov \
    -format UDZO \
    "$DMG_PATH" \
    2>&1

if [ ! -f "$DMG_PATH" ]; then
    fail "DMG creation failed."
fi

# Staple the DMG too
xcrun stapler staple "$DMG_PATH"

success "DMG created and stapled: $DMG_NAME"

# ─────────────────────────────────────────────────────────────
# Sign for Sparkle
# ─────────────────────────────────────────────────────────────

step "7" "Signing DMG for Sparkle (EdDSA)"

SPARKLE_SIG_OUTPUT=$("$SPARKLE_BIN/sign_update" "$DMG_PATH" 2>&1)

echo "$SPARKLE_SIG_OUTPUT"

# Extract signature and length
ED_SIGNATURE=$(echo "$SPARKLE_SIG_OUTPUT" | grep -o 'sparkle:edSignature="[^"]*"' | sed 's/sparkle:edSignature="//;s/"//')
FILE_LENGTH=$(echo "$SPARKLE_SIG_OUTPUT" | grep -o 'length="[^"]*"' | sed 's/length="//;s/"//')

if [ -z "$ED_SIGNATURE" ] || [ -z "$FILE_LENGTH" ]; then
    fail "Could not extract Sparkle signature. See output above."
fi

success "Sparkle signature generated"
info "Signature: ${ED_SIGNATURE:0:40}..."
info "Length:    $FILE_LENGTH"

# ─────────────────────────────────────────────────────────────
# Generate appcast.xml
# ─────────────────────────────────────────────────────────────

step "8" "Generating appcast.xml"

PUB_DATE=$(date -u "+%a, %d %b %Y %H:%M:%S %z")
APPCAST_PATH="$RELEASES_DIR/appcast.xml"

# Always generate a clean appcast (with the new version as the latest item)
# If we need to keep older versions in the future, we can read the old file first

cat > "$APPCAST_PATH" << APPCAST_EOF
<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0" xmlns:sparkle="http://www.andymatuschak.org/xml-namespaces/sparkle" xmlns:dc="http://purl.org/dc/elements/1.1/">
    <channel>
        <title>Second Draft Updates</title>
        <link>${APPCAST_URL}</link>
        <language>en</language>
        <item>
            <title>Version ${MARKETING_VERSION}</title>
            <pubDate>${PUB_DATE}</pubDate>
            <sparkle:version>${BUILD_NUMBER}</sparkle:version>
            <sparkle:shortVersionString>${MARKETING_VERSION}</sparkle:shortVersionString>
            <description><![CDATA[
                <h2>What's New in ${MARKETING_VERSION}</h2>
                <p>See release notes on GitHub for details.</p>
            ]]></description>
            <enclosure
                url="${DOWNLOAD_URL}"
                sparkle:edSignature="${ED_SIGNATURE}"
                length="${FILE_LENGTH}"
                type="application/octet-stream"/>
        </item>
    </channel>
</rss>
APPCAST_EOF

# Verify the appcast is valid XML
if command -v xmllint &> /dev/null; then
    if xmllint --noout "$APPCAST_PATH" 2>/dev/null; then
        success "appcast.xml is valid XML"
    else
        warn "appcast.xml has XML issues. Please verify manually."
    fi
else
    info "xmllint not available — skipping XML validation"
fi

success "appcast.xml generated"
info "Appcast URL:  $APPCAST_URL"
info "Download URL: $DOWNLOAD_URL"

# ─────────────────────────────────────────────────────────────
# Update landing page
# ─────────────────────────────────────────────────────────────

step "9" "Updating landing page with v${MARKETING_VERSION} download link"

# Copy the source landing page to the root (GitHub Pages serves from root)
cp "$LANDING_DIR/index.html" "$RELEASES_DIR/index.html"

LANDING_INDEX="$RELEASES_DIR/index.html"

# Update the hero download button (the one with href="#download")
# Change href to the DMG URL and update the label to include version
sed -i '' 's|<a href="#download" class="btn-primary animate-up delay-3">|<a href="'"$DOWNLOAD_URL"'" class="btn-primary animate-up delay-3">|g' "$LANDING_INDEX"

# Update the CTA download button (the one with href="#")
# This is the bottom "Download for Mac" button in the final-cta section
sed -i '' 's|<a href="#" class="btn-primary">|<a href="'"$DOWNLOAD_URL"'" class="btn-primary">|g' "$LANDING_INDEX"

# Update both button labels to include the version number
# "Download for Mac" → "Download for Mac · v1.1"
sed -i '' 's|>      Download for Mac|>      Download for Mac · v'"$MARKETING_VERSION"'|g' "$LANDING_INDEX"

# Verify the changes were applied
BUTTON_COUNT=$(grep -c "$DOWNLOAD_URL" "$LANDING_INDEX" || true)
if [ "$BUTTON_COUNT" -ge 2 ]; then
    success "Both download buttons updated with DMG link"
elif [ "$BUTTON_COUNT" -eq 1 ]; then
    warn "Only 1 download button updated (expected 2). Check index.html manually."
else
    warn "No download buttons were updated. The HTML structure may have changed."
    info "Please update the download links in index.html manually."
fi

VERSION_LABEL_COUNT=$(grep -c "v${MARKETING_VERSION}" "$LANDING_INDEX" || true)
if [ "$VERSION_LABEL_COUNT" -ge 2 ]; then
    success "Version label v${MARKETING_VERSION} added to both buttons"
else
    warn "Version label may not be on all buttons. Check index.html."
fi

info "Landing page: $LANDING_URL"

# ─────────────────────────────────────────────────────────────
# Push to GitHub + Create Release
# ─────────────────────────────────────────────────────────────

step "10" "Publishing to GitHub"

cd "$RELEASES_DIR"

# Stage appcast and landing page
git add appcast.xml index.html

git commit -m "Release v${MARKETING_VERSION} (build ${BUILD_NUMBER}) — update appcast + landing page" 2>/dev/null || {
    warn "Nothing new to commit (files unchanged)"
}

info "Pushing to GitHub (triggers GitHub Pages deploy)..."
git push origin main

success "Appcast + landing page pushed to GitHub"

# Delete existing release if user confirmed earlier
if [ "$DELETE_EXISTING_RELEASE" = true ]; then
    info "Deleting existing release $TAG_NAME..."
    gh release delete "$TAG_NAME" --repo "$GITHUB_REPO" --yes 2>&1 || true
    git push origin --delete "$TAG_NAME" 2>&1 || true
fi

info "Creating GitHub Release..."

gh release create "$TAG_NAME" \
    "$DMG_PATH" \
    --repo "$GITHUB_REPO" \
    --title "Second Draft ${MARKETING_VERSION}" \
    --notes "## Second Draft v${MARKETING_VERSION} (build ${BUILD_NUMBER})

### Download
Download **${DMG_NAME}** below and drag Second Draft to your Applications folder.

### What's New
See the [landing page](${LANDING_URL}) for details.

### Auto-Updates
If you already have Second Draft installed, it will update automatically via Sparkle.

---
*Signed with Developer ID + Apple Notarized*" \
    2>&1

success "GitHub Release created with DMG attached"

# ─────────────────────────────────────────────────────────────
# Verify
# ─────────────────────────────────────────────────────────────

step "11" "Verification"

echo ""

# Check appcast is accessible
info "Checking appcast URL (GitHub Pages may take 1-2 min to deploy)..."
sleep 5
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$APPCAST_URL" 2>&1)

if [ "$HTTP_STATUS" = "200" ]; then
    success "Appcast is live at $APPCAST_URL"
else
    warn "Appcast returned HTTP $HTTP_STATUS. GitHub Pages may still be deploying."
    info "Check manually in a minute: $APPCAST_URL"
fi

# Check landing page
LANDING_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$LANDING_URL" 2>&1)

if [ "$LANDING_STATUS" = "200" ]; then
    success "Landing page is live at $LANDING_URL"
else
    warn "Landing page returned HTTP $LANDING_STATUS. May still be deploying."
fi

# Check DMG download URL via GitHub release
RELEASE_URL="https://github.com/${GITHUB_REPO}/releases/tag/${TAG_NAME}"
info "Release page: $RELEASE_URL"

# ─────────────────────────────────────────────────────────────
# Cleanup
# ─────────────────────────────────────────────────────────────

step "12" "Cleanup"

rm -rf "$BUILD_DIR"
success "Cleaned up temp build directory"

# ─────────────────────────────────────────────────────────────
# Summary
# ─────────────────────────────────────────────────────────────

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  🎉 Release Complete!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${CYAN}Version${NC}        ${MARKETING_VERSION} (build ${BUILD_NUMBER})"
echo -e "  ${CYAN}DMG${NC}            ${RELEASES_DIR}/${DMG_NAME}"
echo -e "  ${CYAN}Appcast${NC}        ${APPCAST_URL}"
echo -e "  ${CYAN}Download${NC}       ${DOWNLOAD_URL}"
echo -e "  ${CYAN}Landing page${NC}   ${LANDING_URL}"
echo -e "  ${CYAN}Release page${NC}   https://github.com/${GITHUB_REPO}/releases/tag/${TAG_NAME}"
echo ""
echo "  📋 Share with testers:"
echo "     ${LANDING_URL}"
echo ""
echo "  ⚠️  For next release, remember to increment version numbers in Xcode FIRST:"
echo "     MARKETING_VERSION (e.g., ${MARKETING_VERSION} → next version)"
echo "     CURRENT_PROJECT_VERSION (e.g., ${BUILD_NUMBER} → $((BUILD_NUMBER + 1)))"
echo ""
