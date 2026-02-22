# PRD: Second Draft — Landing Page

**Version:** 1.0
**Last Updated:** February 21, 2026
**Author:** Jesus
**Status:** Draft — Ready for Review

---

## 1. Overview

### Goal
Create a high-converting landing page for **Second Draft**, a macOS menu bar app that helps non-native English speakers improve their written communication using AI. The page should optimize for two primary outcomes:

1. **Primary CTA:** Drive app downloads (Download for Mac)
2. **SEO:** Rank for queries related to AI writing assistance, grammar correction, and English writing improvement for professionals

### Target Audience
- Non-native English speakers working in tech (Bay Area and beyond)
- Product Managers, Project Managers, and other professionals who write daily
- People who value privacy and want control over their AI tools
- macOS users (13+)

### Competitive Landscape
| Competitor | Positioning | Key Differentiator |
|---|---|---|
| **Grammarly** | "Free AI Writing Assistance" — broad, enterprise-focused | Browser extension, freemium, cloud-based |
| **Wordtune** | "Express yourself with confidence" — rewrites & paraphrasing | Web-based, cloud-processed, subscription |
| **Second Draft** | Privacy-first, native macOS, works anywhere | Local processing, user-owned API keys, no cloud dependency |

**Our edge:** Privacy-first (no cloud, user-owned keys), native macOS integration (works in *any* app via Option+Space), and transparent AI (choose your own provider).

> ⚠️ **Note:** Wordtune's hero headline is literally "Express yourself with confidence." We must differentiate our messaging. See Section 3 for updated copy direction.

---

## 2. Page Structure & Layout

The page follows a single-column, vertically scrolling layout inspired by Apple's clean product pages.

```
┌─────────────────────────────────────────────┐
│  Nav Bar (sticky)                           │
│  Logo · How it works · Features · Download  │
├─────────────────────────────────────────────┤
│                                             │
│  SECTION 1: Hero                            │
│  ┌───────────────┬─────────────────────┐    │
│  │  Headline     │  Product visual     │    │
│  │  Subheadline  │  (screenshot/GIF)   │    │
│  │  [Download]   │                     │    │
│  └───────────────┴─────────────────────┘    │
│                                             │
├─────────────────────────────────────────────┤
│                                             │
│  SECTION 2: Problem Statement               │
│  Centered text, single impactful line       │
│                                             │
├─────────────────────────────────────────────┤
│                                             │
│  SECTION 3: How It Works                    │
│  ┌──────────┬──────────┬──────────┐         │
│  │  Step 1  │  Step 2  │  Step 3  │         │
│  └──────────┴──────────┴──────────┘         │
│                                             │
├─────────────────────────────────────────────┤
│                                             │
│  SECTION 4: Feature List                    │
│  ┌─────────┬───────────────────────┐        │
│  │Feature 1│  Visual / Description │        │
│  ├─────────┼───────────────────────┤        │
│  │Feature 2│  Visual / Description │        │
│  ├─────────┼───────────────────────┤        │
│  │Feature 3│  Visual / Description │        │
│  └─────────┴───────────────────────┘        │
│                                             │
├─────────────────────────────────────────────┤
│                                             │
│  SECTION 5: Final CTA                       │
│  Headline + Download button + fine print    │
│                                             │
├─────────────────────────────────────────────┤
│  Footer                                     │
│  Links · Copyright · Social                 │
└─────────────────────────────────────────────┘
```

---

## 3. Section-by-Section Specifications

### Nav Bar (Sticky Header)
- **Left:** Second Draft logo (the «+» icon, dark version)
- **Center/Right:** Navigation links — How it works · Features · Download
- **Far Right:** Download CTA button (small, outlined)
- **Behavior:** Sticky on scroll, subtle backdrop blur, appears after scrolling past hero

---

### Section 1: Hero — Header & Hero Message

**Layout:** Two-column split (50/50 on desktop, stacked on mobile)

#### Subsection 1 (Left)
**Headline:** Say what you mean. Clearly. ✅ FINAL

**Subheadline:** Select any text. Press one shortcut. Get instant rewrites for grammar, clarity, tone, and structure. ✅ FINAL

**CTA Button:**
- Label: `Download for Mac`
- Style: Solid fill, primary accent color, large
- Below CTA: Fine print — `Requires macOS 13+ · Free beta · Uses your own API keys`
- Icon: Apple logo (SF Symbol: `apple.logo`) before "Download for Mac"

#### Subsection 2 (Right)
- **Content:** Static screenshot of the floating panel ✅ FINAL
- **Background treatment:** Subtle gradient or soft shadow to give depth (reference the dark onboarding screenshot from the design board)
- **Recommendation:** Show the floating panel overlaying a realistic app context (e.g., Slack or Gmail) to communicate "works anywhere"
- **Future iteration:** Replace with animated GIF or looping video once beta feedback confirms the product flow

#### Hero Background Animation — "Word Rain" ✅ FINAL

A subtle, ambient animation in the hero section background that reinforces the "writing" theme:

- **Type:** Vertical columns of writing-related words cascading downward
- **Font:** IBM Plex Mono, 12px
- **Words used:** draft, clarity, tone, rewrite, grammar, refine, voice, express, polish, compose, convey, revise, fluent, concise, articulate, communicate, confident, edit, improve, structure, message, email, writing, words, text, correct, enhance, transform, natural
- **Opacity:** 3-7.5% — barely visible, reads as texture not content
- **Animation:** Each column falls top-to-bottom at varying speeds (14-34 seconds per cycle)
- **Density:** ~20 columns initially, new column spawns every 1.4 seconds
- **Behavior:** `pointer-events: none`, sits behind hero content at z-index 0
- **Inspiration:** A restrained, editorial take on the Matrix rain effect — communicates "language is alive and being transformed"
- **Purpose:** Adds visual dynamism to the hero without competing with the product screenshots; reinforces that Second Draft is about words and writing

---

**Layout:** Full-width, centered text. Generous vertical padding (120px+). Minimal.

**Content:** You know what you want to say. You just need the right words. ✅ FINAL

**Design notes:**
- Large display font (36-48px), medium weight
- Slightly muted color (not full black — use the darker steel palette tone)
- Optional: subtle background texture or divider line above/below
- This section acts as an emotional bridge between the hero and the feature explanation

---

### Section 3: How It Works

**Layout:** Three-column horizontal steps (desktop), vertical stack (mobile)

| Step | Title | Description | Visual |
|---|---|---|---|
| 1 | **Select any text** | In any app — emails, messages, documents, Slack, anywhere on macOS. | Row of popular app icons: Mail, Slack, Gmail, LinkedIn, Notion, Google Docs |
| 2 | **Press ⌥ + Space** | One keyboard shortcut. That's it. Customize it to whatever you prefer. | Stylized keyboard shortcut visual showing the keys |
| 3 | **Get 4 AI rewrites** | Grammar, Clarity, Tone, and Structure — all at once, instantly. | Mini screenshot of the floating panel with 4 tabs |

**Design notes:**
- Each step has a number indicator (1, 2, 3) with the accent color
- App icons in Step 1 should be recognizable but small (24-32px). Use official/SF Symbol versions where possible
- Step 2 keyboard visual could be a stylized `⌥` + `␣` key cap illustration
- Step 3 should show or reference the actual floating panel UI

---

### Section 4: Feature List

**Layout:** Alternating rows — feature text on one side, visual/illustration on the other. Rows alternate left-right alignment.

#### Feature 1: Context-Aware Configs
- **Headline:** Set the right tone for every app.
- **Description:** Configure different writing styles for different contexts. Professional in Gmail, casual in Slack, confident on LinkedIn. Second Draft remembers your preferences for each app.
- **Visual:** Side-by-side comparison showing different tone outputs, or a settings UI mockup showing app-specific configurations
- **App icons to show:** Gmail, Slack, LinkedIn

#### Feature 2: Smart Diff Highlights
- **Headline:** See exactly what changed.
- **Description:** Grammar fixes show word-level green highlights so you can see every correction at a glance. Learn from each suggestion and improve your writing over time.
- **Visual:** Before/after text comparison with green diff highlights (use an actual example from the app)

#### Feature 3: Your Keys. Your Data. Period.
- **Headline:** Your keys. Your data. Period.
- **Description:** Connect your own Anthropic, OpenAI, or Google API key. Stored securely in macOS Keychain. No cloud servers, no tracking, no data collection. Switch providers anytime.
- **Visual:** Provider logos (Claude, GPT, Gemini) + macOS Keychain/lock icon. Could show a simplified security diagram.
- **Supported providers:** Anthropic Claude · OpenAI GPT · Google Gemini

**Design notes:**
- Each feature row should have generous whitespace (80-100px padding)
- Alternating image left/right pattern creates visual rhythm
- Headlines should be bold and scannable
- Descriptions kept to 2-3 sentences max

---

### Section 5: Final CTA — Hero Message Reminder

**Layout:** Full-width, centered. High contrast background (dark steel from palette or gradient).

**Headline:** Your second draft is one shortcut away. ✅ FINAL

**CTA Button:** `Download for Mac` (same style as hero, but inverted if on dark background)

**Fine print below CTA:**
`Requires macOS 13+ · Free beta · Uses your own API keys`

**Optional additions:**
- Beta badge or "Join the Beta" messaging if appropriate
- Small testimonial or user count once available
- Link to "How to get started" or setup guide

---

### Footer

- **Left:** Second Draft logo + © 2026 Second Draft
- **Center:** Links — Privacy Policy · Terms · Contact · GitHub (if open source)
- **Right:** Social links (Twitter/X, GitHub if applicable)
- **Style:** Minimal, matches nav bar styling

---

## 4. Design System

### Typography

| Element | Font | Weight | Size (Desktop) | Size (Mobile) |
|---|---|---|---|---|
| Nav links | Poppins | Regular (400) | 16px | 14px |
| Hero headline | Poppins | Bold (700) | 56-64px | 36-40px |
| Hero subheadline | Poppins | Regular (400) | 20-24px | 16-18px |
| Section headlines | Poppins | SemiBold (600) | 36-48px | 28-32px |
| Body text | Poppins | Regular (400) | 18px | 16px |
| Fine print | Poppins | Regular (400) | 14px | 12px |
| CTA button | Poppins | SemiBold (600) | 18px | 16px |
| Word Rain (bg animation) | IBM Plex Mono | Regular (400) | 12px | 12px |

### Color Palette — "Ink & Paper" ✅ FINAL

Monochrome, editorial, confident. Inspired by Notion, Apple, and Vercel. The absence of color accent lets the dark-themed product screenshots become the only color on the page.

| Name | Hex | Usage |
|---|---|---|
| Foreground / Text | `#0A0A0A` | Headlines, body text, CTA buttons |
| Secondary Text | `#666666` | Subheadlines, descriptions |
| Muted Text | `#999999` | Fine print, captions |
| Background | `#FFFFFF` | Page background |
| Surface / Cards | `#FAFAFA` | Section backgrounds (alternating), problem section |
| Border / Divider | `#EEEEEE` | Subtle separators |
| Light Gray | `#F0F0F0` | Tags, badges, hover states |
| Mid Gray | `#D1D1D1` | Decorative underlines, accents |
| Dark Gray | `#333333` | Secondary emphasis, tag text |
| CTA / Primary | `#0A0A0A` | Buttons (black on white sections) |
| CTA Hover | `#333333` | Button hover states |
| Dark Surface | `#0A0A0A` | Section 5 (final CTA) background |
| Dark Text (on dark) | `#FFFFFF` | Text on dark backgrounds |

**Design rationale:** Near-monochrome creates maximum contrast and lets the product screenshots (which have a dark theme with green highlights) become the sole color element on the page. This is a deliberate differentiator — Grammarly owns green, Wordtune owns purple, generic SaaS owns blue. Second Draft owns black & white.

### General Style
- **Direction:** Ink & Paper — monochrome, editorial, confident
- **Inspiration:** Notion, Apple, Vercel
- **Key principle:** Near-monochrome palette lets the dark-themed product screenshots become the sole color element on the page
- **Hero animation:** Word Rain — vertical columns of writing-related words in IBM Plex Mono cascading at low opacity
- **Overall feel:** Clean, Apple-like, maximum contrast, zero color distraction
- **System:** SF Symbols (Apple) where possible
- **App icons:** Official app logos for Mail, Slack, Gmail, LinkedIn, Notion, Google Docs (Step 1 visual)
- **Provider logos:** Anthropic, OpenAI, Google (Feature 3)
- **Style:** Monoline, consistent stroke weight, matches Poppins geometric feel

### Spacing & Grid
- **Max content width:** 1200px, centered
- **Section padding:** 100-120px vertical
- **Column gap (hero):** 60-80px
- **Grid:** 12-column on desktop, single column on mobile
- **Breakpoints:** Desktop (1024px+), Tablet (768-1023px), Mobile (<768px)

---

## 5. SEO Requirements

### Target Keywords
- Primary: `AI writing assistant mac`, `grammar checker macOS`, `writing improvement app`
- Secondary: `AI rewrite tool`, `text clarity tool`, `writing assistant for non-native speakers`, `private AI writing app`
- Long-tail: `best writing app for non-native English speakers`, `macOS AI grammar checker with API key`

### Technical SEO
- Semantic HTML5 (`<header>`, `<main>`, `<section>`, `<footer>`)
- Proper heading hierarchy (single `<h1>` in hero, `<h2>` per section, `<h3>` for features)
- Meta title: `Second Draft — AI Writing Assistant for macOS`
- Meta description: `Improve your writing instantly with AI-powered rewrites for grammar, clarity, tone, and structure. Private, native macOS app. Uses your own API keys.`
- Open Graph and Twitter Card meta tags with product screenshot
- Alt text on all images
- Schema.org markup (`SoftwareApplication` type)
- Fast load times (optimize images, lazy load below fold)
- Mobile-responsive design

### Page URL
- `https://seconddraft.app` (or chosen domain)

---

## 6. Technical Considerations

### Stack (Suggested)
- **Static site generator:** Next.js (static export) or Astro for performance
- **Styling:** Tailwind CSS (pairs well with utility-first approach)
- **Hosting:** Vercel or Netlify (free tier, fast CDN)
- **Font loading:** Google Fonts (Poppins) with `display: swap`
- **Analytics:** Plausible or Fathom (privacy-friendly, aligns with brand values)

### Performance Targets
- Lighthouse score: 95+ across all categories
- LCP (Largest Contentful Paint): < 2.5s
- CLS (Cumulative Layout Shift): < 0.1
- FID (First Input Delay): < 100ms

### Accessibility
- WCAG 2.1 AA compliance
- Keyboard navigable
- Sufficient color contrast (4.5:1 minimum for text)
- Screen reader compatible
- Reduced motion support

---

## 7. Content Assets Needed

| Asset | Type | Status | Notes |
|---|---|---|---|
| Product screenshot (floating panel) | Image/GIF | ✅ Available | From existing beta |
| App icon (« + » logo) | SVG | ✅ Available | Light and dark versions |
| Onboarding screen | Screenshot | ✅ Available | From design board |
| App icons (Slack, Gmail, etc.) | SVG/PNG | 🔲 Need to source | Official logos or SF Symbols |
| Provider logos (Claude, GPT, Gemini) | SVG | 🔲 Need to source | From provider brand guidelines |
| Keyboard shortcut visual | Illustration | 🔲 Need to create | Stylized ⌥ + Space key caps |
| Diff highlights example | Screenshot | 🔲 Need to capture | Real before/after from app |
| Context-aware config visual | Screenshot/Mockup | 🔲 Need to create | App settings or comparison |
| Hero background/gradient | Design asset | 🔲 Need to create | Subtle, matches palette |
| OG image for social sharing | Image (1200x630) | 🔲 Need to create | Logo + tagline + screenshot |

---

## 8. Open Questions & Decisions Needed

| # | Question | Options | Decision |
|---|---|---|---|
| 1 | Hero headline | "Say what you mean. Clearly." | ✅ Done |
| 2 | Subheadline | "Select any text. Press one shortcut. Get instant rewrites for grammar, clarity, tone, and structure." | ✅ Done |
| 3 | Problem statement | "You know what you want to say. You just need the right words." | ✅ Done |
| 4 | Final CTA headline | "Your second draft is one shortcut away." | ✅ Done |
| 5 | Domain name | TBD — deciding later | **TBD** |
| 6 | Analytics tool | Skipping for now — add post-launch | **Deferred** |
| 7 | Hero visual | Static screenshot of floating panel | ✅ Done |
| 8 | Color palette exact hex values | Ink & Paper (monochrome) palette finalized | ✅ Done |
| 9 | Download mechanism | Direct .dmg download from website | ✅ Done |
| 10 | Beta messaging | "Free beta" | ✅ Done |

---

## 9. Success Metrics

| Metric | Target | How to Measure |
|---|---|---|
| Download conversion rate | > 5% of visitors | CTA clicks / page visits |
| Bounce rate | < 50% | Analytics |
| Average time on page | > 45 seconds | Analytics |
| Scroll depth | > 70% reach Section 4 | Scroll tracking |
| SEO ranking | Top 20 for primary keywords within 3 months | Search Console |
| Page load speed | < 2s on 3G | Lighthouse |

---

*This PRD is a living document. Sections marked TBD require team decision before development begins.*
