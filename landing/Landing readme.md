# Second Draft — Landing Page

## Project Files

```
├── index.html                  ← Final landing page (Ink & Paper + Word Rain)
├── PRD.md                      ← Product Requirements Document (all decisions finalized)
├── README.md                   ← This file
├── images/
│   ├── panel_screenshot_1.png  ← Floating panel (original + suggestions)
│   └── panel_screenshot_2.png  ← Floating panel (all 4 rewrites)
└── explorations/
    ├── color-exploration-v1-warm-neutral.html
    ├── color-directions-v2-ink-clay-alpine.html
    ├── hero-background-variations.html
    └── landing-page-warm-neutral.html
```

## Quick Start

Open `index.html` in a browser — everything is self-contained (images are base64-embedded).

## Design Decisions

- **Palette:** Ink & Paper (monochrome) — inspired by Notion, Apple, Vercel
- **Font:** Poppins (UI) + IBM Plex Mono (Word Rain animation)
- **Hero animation:** Word Rain — vertical cascading word columns at 3-7.5% opacity
- **Screenshots:** Real product screenshots with backgrounds removed, shown as carousel

## Before Launch — Update These

- [ ] Replace `href="#"` on both "Download for Mac" buttons with your .dmg URL
- [ ] Update footer links: Privacy Policy, Terms, Contact
- [ ] Add domain to meta tags (og:url, canonical)
- [ ] Add OG image for social sharing
- [ ] Set up domain and hosting (Vercel/Netlify recommended)

## If You Want to Decouple Images from Base64

Replace `src="data:image/png;base64,..."` with `src="images/panel_screenshot_1.png"` etc.
The standalone PNG files are in the `images/` folder.

## Explorations Folder

Contains all color and animation explorations we went through during the design process.
Kept for reference — not needed for production.
