# PADE Landing Site — CLAUDE.md

## Project overview

One-page static marketing site for **PADE** — a mobile POS app for freelancers and gig workers, built by **The Future of Work (TFO)**. Conversion-focused, impulse-download oriented, mobile-first. No frameworks — plain HTML/CSS/JS only.

**Live URL:** https://pade-site.vercel.app  
**Deploy command:** `vercel deploy --prod --scope allagesshows-projects`  
**Project directory:** `/Users/mattchait/pade-site/`  
**Local dev:** `npx live-server --port=8081` (auto-reloads on save)

---

## Files

| File | Purpose |
|------|---------|
| `index.html` | Single-page site, all content |
| `styles.css` | All styles, ~1000 lines |
| `Akira.otf` | Custom display font (user-supplied, do not rename) |
| `public/images/pade-mockup-3-portrait.png` | Hero phone mockup (portrait, currently active) |
| `public/images/pade-mockup-3-left.png` | Hero phone mockup (3/4 angle, not in use) |
| `public/images/pade-mockup-3-landscape.png` | Landscape mockup (not in use) |
| `vercel.json` | Vercel config (cleanUrls, security headers) |
| `netlify.toml` | Netlify fallback config |

---

## Brand palette (exact TFO colors)

```css
--blue:      #1A1AFF   /* Electric Blue — primary brand */
--blue-dark: #1010CC
--blue-dim:  rgba(26,26,255,0.12)
--lime:      #B5FF4D   /* Lime Green — accent/CTA */
--lime-dark: #8FCC30
--lime-dim:  rgba(181,255,77,0.12)
--bg:        #000000
--white:     #FFFFFF
```

Do not substitute other yellows or greens — these are exact palette values from tfo.work.

---

## Typography

- **Body:** Inter (Google Fonts, weights 300–900)
- **Display/Logo:** Akira (`Akira.otf`) — used for: nav logo, footer logo, GigSwitcher™ pill, FourPay™ pill, TryPade.com pill, team member names, step numbers 01–04, scrolling marquee
- Akira utility class: `.akira` — add alongside eyebrow/other classes

---

## Page sections (in order)

1. **Nav** — fixed, blurs on scroll, lime PADE logo, "Try PADE" lime CTA button
2. **Hero** — dark bg, blue glow, "We built the app that *we* always *wanted*." headline. HTML split into 3 grid children: `.hero-top` (eyebrow/headline/sub), `.hero-visual` (mockup image), `.hero-cta` (store buttons + note). On mobile: stacks top → visual → cta. On desktop: 2-col grid, visual spans both rows.
3. **Intro Band** — electric blue scrolling marquee (Akira font, 28s loop), GPU-composited with `translate3d`. Trailing `·` on each segment for seamless loop. Pauses on hover.
4. **This Is Personal** (`#why`) — white bg, 3-column comparison grid: Too Basic (Venmo/CashApp/Zelle) | Just Right (PADE, blue card) | Too Complicated (Square/Shopify/Toast)
5. **GigSwitcher™** (`#gigswitcher`) — dark bg (`--bg-2`), 3 persona cards, blue banner callout. Headline: "You've got *a few* million dollar ideas. We built an app for that."
6. **FourPay™** (`#checkout`) — white bg, 4 payment method cards with icon left of label (`.quad-card-top` flex row). Invoice card highlighted with blue tint + 2px blue border + "The differentiator" badge inline with label. Blue callout banner with lime "Start Today" button.
7. **How It Works** (`#how`) — dark bg (`--bg`), steps 01–04 in Akira font (blue), 4-column grid
8. **What's Inside** (`#features`) — **blue bg** (`--blue`), 8 feature cards with lime icon glows. Headline: "A real business app." in lime, "In your pocket." in white.
9. **About Us** (`#team`) — off-white bg, 6 team members with square photo placeholders
10. **Final CTA** (`#cta`) — dark bg, blue glow, "Stop spinning. Start selling.", App Store + Google Play buttons
11. **Footer** — black, PADE lime logo, links to tfo.work

---

## Key CSS patterns

### Eyebrow labels
```css
.ey-lime / .ey-green / .ey-white  /* all identical — lime tint, lime text */
.ey-blue   /* blue tint, #7B7BFF text */
.ey-light  /* for sections with light/white bg */
```
`ey-green` and `ey-white` are intentional aliases for `ey-lime` — the HTML uses all three names.

### Buttons
```css
.btn-green  /* lime bg, black text — alias for btn-lime */
.btn-lime   /* lime bg, black text */
.btn-blue   /* blue bg, white text */
.btn-sm     /* smaller padding variant */
```
Never use `.btn-blue` on a blue background — zero contrast. Use `.btn-green` with `color:#000` instead.

### Fade-in animation
Elements with `.fi` class start hidden and fade in on scroll via IntersectionObserver. Add `.fi-delay-1/2/3` for staggered delays.

### Comparison cards (`.comparison`)
- 3-col grid on desktop, 1-col on mobile
- Mobile order: Too Basic (1st), Too Complicated (2nd), PADE blue card (3rd/bottom) — controlled via CSS `order` property
- Center card (`.comp-col-mid`) has `background: var(--blue)` — white text throughout

### Scrolling marquee
Two identical `.intro-band-segment` divs inside `.intro-band-track`. Uses `translate3d(-50%, 0, 0)` for GPU compositing. Each segment ends with a trailing `<span>·</span>` so the loop seam matches internal spacing. Pauses on hover.

### FourPay cards (`.quad-card`)
Icon and label are wrapped in `.quad-card-top` (flex row, `align-items: center`, `gap: 14px`). Invoice card has an additional inline flex wrapper for label + badge with `justify-content: space-between`.

### What's Inside cards (`.feat-item`)
Blue background section. On desktop: flex column (icon above title). On mobile: CSS grid (icon left of title, desc spans full width below).

### Hero grid
Three direct children of `.hero-grid`: `.hero-top`, `.hero-visual`, `.hero-cta`.
- Mobile (`max-width: 859px`): flex column, ordered top → visual → cta. Store buttons centered.
- Desktop (`min-width: 860px`): 2-col CSS grid. Visual spans both rows (`grid-row: 1 / 3`).

---

## Mobile-only CSS (at bottom of styles.css)

All mobile fixes are in two media query blocks at the end of `styles.css`:

- `@media (max-width: 859px)` — hero flex/order layout
- `@media (min-width: 860px)` — hero desktop grid with visual row-span
- `@media (max-width: 640px)` — all other mobile fixes:
  - Comparison cards: tighter padding
  - `.h-lg` bumped to `2.3rem`
  - Banner CTAs (`gs-banner`, `quad-callout`) buttons right-aligned (`align-self: flex-end`)
  - How It Works steps: CSS grid with number left of title
  - What's Inside: CSS grid with icon left of title
  - Team: 2-column grid

---

## JavaScript (inline, bottom of index.html)

```js
// IntersectionObserver for .fi → .on scroll animations
const io = new IntersectionObserver(..., { threshold: 0.08 });
document.querySelectorAll('.fi').forEach(el => io.observe(el));

// Nav border on scroll
const nav = document.querySelector('.nav');
window.addEventListener('scroll', () => {
  nav.classList.toggle('scrolled', window.scrollY > 10);
}, { passive: true });
```

---

## Team members

| Initials | Name | Role |
|----------|------|------|
| MC | Matt Chait | Founder & CEO |
| CC | Cal Campbell | Co-Founder |
| BD | Brian Dao | CTO (bio is placeholder lorem ipsum — needs real bio) |
| BL | Brian Lau | Operations |
| SK | Scott Kay | Financial Lead |
| LA | Liana Ahn | Product & UX |

To add a real headshot, replace `<div class="member-photo-placeholder">XX</div>` with `<img src="photo.jpg" alt="Name">` inside the `.member-photo` div.

---

## Product differentiators

**GigSwitcher™** — Multiple gigs/businesses in one app, one login. Tap to switch between them. Unique in the market.

**FourPay™** — Four checkout methods in a single cart: Cash, Card (tap-to-pay via Stripe, no hardware), QR Code, and Invoice (sent inline at checkout via phone/email — not a separate app flow). Invoice is the key differentiator; it shows as pending in Orders until paid.

---

## Competitor positioning

| Too Basic | Too Complicated |
|-----------|----------------|
| Venmo | Square |
| Cash App | Shopify |
| Zelle | Toast |

Framing: the others are "built for friends" or "built for big business" — PADE is "built for us" (freelancers).

---

## Tone

Inclusive "we built this for us" — not investor pitch, not feature dump. Target: freelancers with very little time and money. Impulse-download focused. CTAs throughout. No emoji bullets. Positive/aspirational framing — multi-gig life is a superpower, not a financial struggle.

---

## Known TODOs (pending user action)

- Add real App Store / Google Play links when app is live
- Replace Brian Dao's lorem ipsum bio with real bio
- Replace all `.member-photo-placeholder` divs with real headshots

---

## Deploy

```bash
./deploy.sh
```

This script deploys to Vercel production AND aliases `trypade.com` in one step. Do not use `vercel deploy --prod` directly — it won't auto-alias `trypade.com` (Vercel CLI quirk with multiple production domains).

**Live URLs:**
- Primary: https://trypade.com
- Alias: https://trypade.app (redirects to trypade.com)
- Vercel: https://pade-site.vercel.app
