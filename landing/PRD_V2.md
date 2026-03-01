# PRD: Second Draft — Landing Page V2

**Version:** 2.0
**Last Updated:** February 28, 2026
**Author:** Jesus + Claude
**Status:** Draft — Ready for Implementation
**Playground file:** `index-playground.html` (copy of V1 for iterating)

---

## 1. Overview

### Goal
Improve the landing page copy and messaging to increase conversion (downloads). The page currently explains what Second Draft does but doesn't create enough emotional pull to make visitors *want* to download it.

### What's Changing (V2 Scope)
- **Copy & messaging only** — layout, design system, and visual structure stay the same
- **Hero section** — new headline, subheadline, and fine print (biggest change)
- **Problem/bridge section** — new aspirational copy
- **Features section** — sharpened descriptions (concise + punchy)
- **Final CTA** — updated fine print to match hero
- **Footer** — simplified (remove placeholder links)

### What's NOT Changing
- Page structure and section order
- Design system (colors, fonts, spacing)
- Animations (word rain, reveal, carousel)
- How It Works section (steps 1-2-3)
- Visual mockups in features section
- JavaScript functionality

---

## 2. Section-by-Section Changes

### Nav Bar
**No changes.** Keep as-is.

---

### Section 1: Hero

#### V1 (Current)
```
Headline:    "Say what you mean. Clearly."
Subheadline: "Select any text. Press one shortcut. Get instant rewrites
              for grammar, clarity, tone, and structure."
Fine print:  "Requires macOS 14+ · Free beta · Uses your own API keys"
```

#### V2 (New)
```
Headline:    "Stop second-guessing every message."
Subheadline: "Select your text. Press one shortcut. Get AI rewrites
              for grammar, clarity, tone, and structure. Done."
Fine print:  "Free · macOS 14+ · No account needed · Bring your own AI
              key (OpenAI, Claude, or Gemini)"
```

#### Rationale
- **Headline** leads with emotional pain (self-doubt, overthinking) instead of an abstract statement. "Stop second-guessing" is universally relatable — works for both non-native speakers and anyone who agonizes over messages.
- **Subheadline** uses staccato rhythm — three short actions then "Done." The contrast is deliberate: the headline is about hesitation, the subheadline is about speed and certainty. Reads fast, feels decisive, very Apple-like cadence.
- **Fine print** changes:
  - "Free" moved to front position (strongest incentive)
  - "No account needed" replaces "Free beta" — reduces friction, signals simplicity
  - "Bring your own AI key" replaces "Uses your own API keys" — BYOB pattern is familiar, less jargon
  - Provider names listed in parentheses make it concrete

---

### Section 2: Problem / Bridge

#### V1 (Current)
```
"You know what you want to say. You just need the right words."
```

#### V2 (New)
```
"What if every message landed exactly the way you meant it?"
```

#### Rationale
- V1 repeated the same sentiment as the hero (pain about finding words). With a stronger hero, this section needs a new job.
- V2 is an **aspirational pivot** — shifts from pain to possibility. Creates the narrative arc:
  - Hero: "You have this problem" (pain)
  - Bridge: "Imagine it solved" (aspiration)
  - How It Works: "Here's how" (solution)
- Question format invites the reader to lean in.

---

### Section 3: How It Works
**No changes.** The three steps are clear and the visual elements (app badges, key caps, suggestion tags) do the heavy lifting. Title stays: "Three steps. One shortcut."

---

### Section 4: Features

#### Feature 1: Context-Aware Configs

**V1:**
> **Set the right tone for every app.**
> Configure different writing styles for different contexts. Professional in Gmail, casual in Slack, confident on LinkedIn. Second Draft remembers your preferences for each app.

**V2:**
> **Set the right tone for every app.**
> Professional in Gmail. Casual in Slack. Confident on LinkedIn. Set it once — Second Draft adapts automatically.

**Changes:** Removed "Configure different writing styles for different contexts" (redundant with the examples). Made it punchier with period-separated examples. "Set it once — adapts automatically" is the key benefit.

---

#### Feature 2: Smart Diff Highlights

**V1:**
> **See exactly what changed.**
> Grammar fixes show word-level green highlights so you can see every correction at a glance. Learn from each suggestion and improve your writing over time.

**V2:**
> **See exactly what changed.**
> Every grammar fix is highlighted word by word. No guessing, no re-reading. Just clear green highlights showing what improved.

**Changes:** Removed "Learn from each suggestion" (nice but unsubstantiated claim). Replaced with the visceral benefit: no guessing, no re-reading. Cleaner.

---

#### Feature 3: Privacy / API Keys

**V1:**
> **Your keys. Your data. Period.**
> Connect your own Anthropic, OpenAI, or Google API key. Stored securely in macOS Keychain. No cloud servers, no tracking, no data collection. Switch providers anytime.

**V2:**
> **Your keys. Your data. Period.**
> Your text never leaves your Mac. Bring your own API key from OpenAI, Anthropic, or Google — stored in macOS Keychain, not on our servers. Because we don't have servers.

**Changes:** Leads with the benefit ("text never leaves your Mac") instead of the mechanic ("connect your own key"). The kicker — "Because we don't have servers" — is memorable and differentiated. It's the kind of line people repeat when recommending the app.

---

### Section 5: Final CTA

#### V1 (Current)
```
Headline:   "Your second draft is one shortcut away."
Fine print: "Requires macOS 13+ · Free beta · Uses your own API keys"
```

#### V2 (New)
```
Headline:   "Your second draft is one shortcut away."  (no change)
Fine print: "Free · macOS 14+ · No account needed · Bring your own AI
             key (OpenAI, Claude, or Gemini)"
```

**Changes:** Headline stays — it's strong. Fine print updated to match the hero for consistency.

---

### Footer

#### V1 (Current)
```
[Logo] © 2026 Second Draft    |    Privacy Policy · Terms · Contact
```

#### V2 (New)
```
[Logo] © 2026 Second Draft
```

**Changes:** Remove placeholder links (Privacy Policy, Terms, Contact) that currently point to `#`. Cleaner, less clutter, avoids broken-link impression. Add them back when real pages exist.

---

## 3. Implementation Checklist

All changes are in the playground file: `index-playground.html`

- [ ] **Hero headline** — Replace "Say what you mean / Clearly" with "Stop second-guessing every message."
- [ ] **Hero subheadline** — Replace with benefit-first version
- [ ] **Hero fine print** — Update to new text
- [ ] **Problem section** — Replace with aspirational question
- [ ] **Feature 1 description** — Swap to punchy version
- [ ] **Feature 2 description** — Swap to punchy version
- [ ] **Feature 3 description** — Swap to punchy version
- [ ] **Final CTA fine print** — Update to match hero
- [ ] **Footer** — Remove placeholder links
- [ ] **Review in browser** — Check all sections look right
- [ ] **Copy playground to source** — When approved, replace `index.html` with playground

---

## 4. Copy Reference (All V2 Copy in One Place)

### Hero
**H1:** Stop second-guessing every message.
**Sub:** Select your text. Press one shortcut. Get AI rewrites for grammar, clarity, tone, and structure. Done.
**Fine print:** Free · macOS 14+ · No account needed · Bring your own AI key (OpenAI, Claude, or Gemini)

### Bridge
**Text:** What if every message landed exactly the way you meant it?

### How It Works
*(No changes)*

### Feature 1
**H3:** Set the right tone for every app.
**Body:** Professional in Gmail. Casual in Slack. Confident on LinkedIn. Set it once — Second Draft adapts automatically.

### Feature 2
**H3:** See exactly what changed.
**Body:** Every grammar fix is highlighted word by word. No guessing, no re-reading. Just clear green highlights showing what improved.

### Feature 3
**H3:** Your keys. Your data. Period.
**Body:** Your text never leaves your Mac. Bring your own API key from OpenAI, Anthropic, or Google — stored in macOS Keychain, not on our servers. Because we don't have servers.

### Final CTA
**H2:** Your second draft is one shortcut away.
**Fine print:** Free · macOS 14+ · No account needed · Bring your own AI key (OpenAI, Claude, or Gemini)

### Footer
© 2026 Second Draft

---

*V2 focuses on copy only. Visual/layout redesign deferred to V3.*
