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
| `styles.css` | All styles |
| `Akira.otf` | Custom display font (user-supplied, do not rename) |
| `public/images/mockups/dashboard-2.png` | Hero phone mockup (angled, transparent bg, own baked-in shadow) |
| `public/images/mockups/dashboard-1.jpeg` | Full-width flat-lay photo (opaque bg) — background image for the Dashboard Showcase section |
| `public/images/mockups/3-screens.png` | 3-phone spread (transparent bg, own shadow) — used in What's Inside section |
| `privacy.html` / `terms.html` | Standalone legal pages, linked from footer |
| `vercel.json` | Vercel config — `outputDirectory: "."` is load-bearing (see note below), cleanUrls, security headers, trypade.app→trypade.com redirect |
| `.vercelignore` | Excludes `node_modules`/`package.json`/`pade-mockup.psd` from deploys (package.json only exists for a local `canvas` mockup script, not the site itself) |
| `netlify.toml` | Netlify fallback config |
| `deploy.sh` | Deploys to Vercel prod and explicitly aliases both `trypade.com` and `trypade.app` to the new deployment (Vercel does not reliably auto-alias with 2 production domains attached) |

**Important:** `vercel.json`'s `"outputDirectory": "."` must stay. Since `public/` exists in this repo, Vercel's "Other" framework preset auto-detects `public` as the output root — without the override, a deploy would serve only the images folder and drop the rest of the site.

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

1. **Nav** — fixed, blurs on scroll, lime PADE logo, "Try PADE" lime CTA button (`href="#cta"`, scrolls to the Final CTA signup section)
2. **Hero** — dark bg, blue glow (now scoped tightly behind the phone image, not the whole section — see Hero grid below), "Building your *dreams* is easier than you think." headline. HTML split into 3 grid children: `.hero-top` (eyebrow/headline/sub/**email signup form**), `.hero-visual` (mockup image), `.hero-cta` (store buttons + note). On mobile: stacks top → visual → cta. On desktop: 2-col grid with **image on the left** (`.hero-visual` is `grid-column: 1`), text/CTA on the right.
3. **Intro Band** — electric blue scrolling marquee (Akira font, 28s loop), GPU-composited with `translate3d`. Trailing `·` on each segment for seamless loop. Pauses on hover.
4. **This Is Personal** (`#why`) — white bg, 3-column comparison grid: Too Basic (Venmo/CashApp/Zelle) | Just Right (PADE, blue card) | Too Complicated (Square/Shopify/Toast)
5. **Dashboard Showcase** (`.dash-showcase`, no id) — new section between "This Is Personal" and GigSwitcher. Full-width, uncropped `dashboard-1.jpeg` flat-lay photo as the entire section (an `<img>`, not a CSS background, specifically so it can never crop regardless of viewport width). Headline overlay ("Built *for* frustrated freelancers *by* frustrated freelancers.") is absolutely positioned over the image's blank right-hand side, sized to match the hero's `.h-xl`, dark text (`var(--text)`) with a subtle text-shadow for legibility against the photo.
6. **GigSwitcher™** (`#gigswitcher`) — dark bg (`--bg-2`), 3 persona cards, blue banner callout. Headline: "You've got *a few* million dollar ideas. We built an app for that."
7. **FourPay™** (`#checkout`) — white bg, 4 payment method cards with icon left of label (`.quad-card-top` flex row). Invoice card highlighted with blue tint + 2px blue border + "The differentiator" badge inline with label. Blue callout banner with lime "Start Today" button.
8. **How It Works** (`#how`) — dark bg (`--bg`), steps 01–04 in Akira font (blue), 4-column grid
9. **What's Inside** (`#features`) — **blue bg** (`--blue`), 8 feature cards with lime icon glows. Headline: "A real business app." in lime, "In your pocket." in white. Followed by `.feat-showcase` — the `3-screens.png` image (transparent bg, own shadow, no extra CSS shadow needed) centered below the grid, max-width 1050px.
10. **About Us** (`#team`) — off-white bg, 6 team members with square photo placeholders
11. **Final CTA** (`#cta`) — dark bg, blue glow, "Stop spinning. Start selling." **This is now a beta email-signup section, not a download section** — the App Store/Google Play buttons were replaced with the same email signup form pattern as the hero (see "Email signup" below). Every CTA button sitewide (nav, comparison card, GigSwitcher banner, FourPay banner) links here via `href="#cta"`.
12. **Footer** — black, PADE lime logo, links to tfo.work, privacy.html, terms.html

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
- Desktop (`min-width: 860px`): 2-col CSS grid, **image on the left**: `.hero-visual { grid-column: 1 }`, `.hero-top`/`.hero-cta { grid-column: 2 }`. Visual spans both rows (`grid-row: 1 / 3`). Column track widths are still `1.1fr 0.9fr` (unchanged from before the swap), so the image sits in the wider track.
- `.hero-img` has no `max-width` cap (removed intentionally) — it fills its grid column/container width for max visual impact. Don't re-add a px cap here without checking with the user first, it was explicitly requested.
- `.hero-glow` lives inside `.hero-visual` (not a sibling of `.container` like it originally was), absolutely centered behind the image at 150% of its box, single blue-only radial gradient, low opacity (~0.2) — kept intentionally subtle per user feedback after an earlier attempt was "too much." `.hero-img` has `z-index: 1` so it renders above the glow.

### Email signup (`sheet-signup` pattern)
Two identical forms — one in the hero (`#hero-signup-form`) under the "No excuses" sub-copy, one in the Final CTA section (`#final-signup-form`) — both POST to the same Google Apps Script Web App URL (`https://script.google.com/macros/s/AKfycbyfDRpLj4BDh0UN4DbPoSuTkY4cbQtNnFUwqrHTmpZa68-By3Y_Xmo6QfQo0qXq9sv3/exec`), which appends `[timestamp, email]` to a Google Sheet the user owns and optionally emails a signup notification. No third-party form service (Mailchimp/Formspree/etc.) — deliberately avoided per user request.
- Forms submit to a hidden `<iframe target="...">`, **not** `fetch` — a plain form POST isn't subject to CORS the way `fetch`/XHR is, so it reliably reaches the Apps Script even though Apps Script doesn't return CORS headers. The response can't be read (opaque), so success is inferred from the iframe's `load` event firing after a real submit (a `submitted` flag ignores the iframe's initial blank-page load).
- Both forms share one `initSignupForm(formId, frameId, noteId)` function (bottom of `index.html`, called twice) rather than duplicating the submit/load handlers.
- Each form has a visually-hidden honeypot input (`.hero-signup-hp`) to silently drop bot submissions.
- Styling: `.hero-signup*` classes for both instances; `.cta-signup`/`.cta-signup-note` are additive modifier classes (on top of the `.hero-signup`/`.hero-signup-note` base classes) that just add `margin: 0 auto` to center the form in the Final CTA's centered layout.
- This exact pattern is saved as a reusable recipe named **`sheet-signup`** for reuse on other static sites — ask if it should be replicated elsewhere.

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

- Hero section still has placeholder App Store / Google Play buttons (`href="#"`) — add real links when the app is live. (The Final CTA section's store buttons were intentionally replaced with the email signup form — don't re-add them there without asking, that was a deliberate pivot to beta signup.)
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
