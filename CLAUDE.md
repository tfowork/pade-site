# PADE Landing Site — CLAUDE.md

## Project overview

One-page static marketing site for **PADE** — a mobile POS app for freelancers and gig workers, built by **The Future of Work (TFO)**. Conversion-focused, impulse-download oriented, mobile-first. No frameworks — plain HTML/CSS/JS only.

**Live URL:** https://pade-site.vercel.app  
**Deploy command:** `vercel deploy --prod --scope allagesshows-projects`  
**Project directory:** `/Users/mattchait/pade-site/`  
**Local dev:** `npx live-server --port=8081` (auto-reloads on save)  
**Browser tab title:** "No hardware. No monthly fees. No excuses. Try PADE" (`<title>` in `index.html` — changed from the original pitch-style title; `og:title`/`twitter:title` still use the original longer copy for social share previews, intentionally left as-is)

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
| `public/images/mockups/vertical-on-concrete.jpg` | Portrait crop of the same concrete flat-lay as `dashboard-1.jpeg`, phone near the bottom — swapped in for the Dashboard Showcase section on mobile (≤640px) via `<picture>`/`<source media>` so the headline can sit above the phone instead of beside it |
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
2. **Hero** — dark bg, blue glow (scoped tightly behind the phone image, not the whole section — see Hero grid below), "Building your *dreams* is easier than you think." headline. HTML split into 4 grid children: `.hero-top` (eyebrow/headline/sub), `.hero-visual` (mockup image), `.hero-signup-wrap` (email signup form), `.hero-cta` (store buttons + note). On mobile: stacks text → phone → signup → store buttons. On desktop: 2-col grid with **image on the left** (`.hero-visual` is `grid-column: 1`), text/signup/CTA stacked in the right column.
3. **Intro Band** — electric blue scrolling marquee (Akira font, 28s loop), GPU-composited with `translate3d`. Trailing `·` on each segment for seamless loop. Pauses on hover.
4. **This Is Personal** (`#why`) — white bg, 3-column comparison grid: Too Basic (Venmo/CashApp/Zelle) | Just Right (PADE, blue card) | Too Complicated (Square/Shopify/Toast)
5. **Dashboard Showcase** (`.dash-showcase`, no id) — section between "This Is Personal" and GigSwitcher. Full-width, uncropped photo as the entire section (an `<img>` inside a `<picture>`, not a CSS background, specifically so it can never crop regardless of viewport width). Desktop/tablet uses `dashboard-1.jpeg` (phone left, blank space right) with the headline overlay right-aligned and vertically centered over the blank area. **Mobile (≤640px)** swaps to `vertical-on-concrete.jpg` via `<source media="(max-width: 640px)">` (phone near the bottom, blank space above) and repositions the overlay to the top-center via a media query on `.dash-showcase-copy`. Headline ("Built *for* frustrated freelancers *by* frustrated freelancers.") uses `.h-xl`, dark text (`var(--text)`), a subtle text-shadow for legibility, and `padding-top` to nudge it down from dead-center (40px base / 57px on mobile — these were both tuned by eye per user feedback, treat as approximate rather than meaningful exact values).
6. **GigSwitcher™** (`#gigswitcher`) — dark bg (`--bg-2`), 3 persona cards, blue banner callout. Headline: "You've got *a few* million dollar ideas. We built an app for that."
7. **FourPay™** (`#checkout`) — white bg, 4 payment method cards with icon left of label (`.quad-card-top` flex row). Invoice card highlighted with blue tint + 2px blue border + "The differentiator" badge inline with label. Blue callout banner with lime "Start Today" button.
8. **How It Works** (`#how`) — dark bg (`--bg`), steps 01–04 in Akira font (blue), 4-column grid
9. **What's Inside** (`#features`) — **blue bg** (`--blue`), 8 feature cards with lime icon glows. Headline: "A real business app." in lime, "In your pocket." in white. Followed by `.feat-showcase` — the `3-screens.png` image (transparent bg, own shadow, no extra CSS shadow needed) centered below the grid, max-width 1140px (container caps at 1160px, so it's intentionally close to full-bleed).
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
Four direct children of `.hero-grid`: `.hero-top` (eyebrow/headline/sub), `.hero-visual` (phone mockup), `.hero-signup-wrap` (email signup form), `.hero-cta` (store buttons + note).
- Mobile (`max-width: 859px`): flex column, `order` values: `.hero-top` 1 → `.hero-visual` 2 → `.hero-signup-wrap` 3 → `.hero-cta` 4 (text, then phone, then signup, then store buttons). `.hero-signup-wrap` and `.hero-cta` are both centered (`text-align: center`; the signup form/note get `margin: 0 auto` since they're flex/block boxes that `text-align` alone won't center).
- Desktop (`min-width: 860px`): 2-col, 3-row CSS grid, **image on the left**: `.hero-visual { grid-column: 1; grid-row: 1 / 4 }` (spans all 3 rows), `.hero-top` (row 1), `.hero-signup-wrap` (row 2), `.hero-cta` (row 3) all in column 2. Column track widths are `1.1fr 0.9fr`, so the image sits in the wider track.
- `.hero-img` has no `max-width` cap (removed intentionally) — it fills its grid column/container width for max visual impact. Don't re-add a px cap here without checking with the user first, it was explicitly requested.
- `.hero-glow` lives inside `.hero-visual` (not a sibling of `.container`), absolutely centered behind the image at 150% of its box, single blue-only radial gradient, low opacity (~0.2) — kept intentionally subtle per user feedback after an earlier attempt (with a second lime ring, higher opacity) was rejected as "horrible." `.hero-img` has `z-index: 1` so it renders above the glow.
- `.hero-headline` (`.h-xl`) is bumped to a fixed `3rem` on mobile (`max-width: 640px`) — the shared `.h-xl` clamp bottoms out around 2rem on narrow screens, which read too small here. This override targets `.hero-headline` specifically, not the shared `.h-xl` class, so `.cta-headline`/`.dash-showcase-headline` (which also use `.h-xl`) are unaffected.

### Email signup (`sheet-signup` pattern)
Two identical forms — one in the hero (`#hero-signup-form`, inside `.hero-signup-wrap`), one in the Final CTA section (`#final-signup-form`) — both POST to the same Google Apps Script Web App URL (`https://script.google.com/macros/s/AKfycbyfDRpLj4BDh0UN4DbPoSuTkY4cbQtNnFUwqrHTmpZa68-By3Y_Xmo6QfQo0qXq9sv3/exec`), which appends a row to a Google Sheet the user owns and optionally emails a signup notification. No third-party form service (Mailchimp/Formspree/etc.) — deliberately avoided per user request, though the user may migrate the Sheet's contacts into an ESP later.
- Forms submit to a hidden `<iframe target="...">`, **not** `fetch` — a plain form POST isn't subject to CORS the way `fetch`/XHR is, so it reliably reaches the Apps Script even though Apps Script doesn't return CORS headers. The response can't be read (opaque), so success is inferred from the iframe's `load` event firing after a real submit (a `submitted` flag ignores the iframe's initial blank-page load).
- Both forms share one `initSignupForm(formId, frameId, noteId)` function (bottom of `index.html`, called twice) rather than duplicating the submit/load handlers.
- Each form has a visually-hidden honeypot input (`.hero-signup-hp`) to silently drop bot submissions.
- Each form also sends hidden fields `source` (`pade-website-hero` or `pade-website-footer`) and `consent_text` (the literal consent sentence shown next to the button, currently *"By submitting, you agree to receive email updates about PADE. Unsubscribe anytime."*) — added so the Sheet has a durable record of what each signup agreed to and where, for compliance and for attesting "these contacts opted in" if/when the list is imported into an ESP like Mailchimp. The Apps Script's `doPost` must append `e.parameter.source`/`e.parameter.consent_text` as extra Sheet columns to actually capture these — that's a manual edit in the user's own Apps Script project, not something this repo controls.
- Styling: `.hero-signup*` classes for both instances; `.cta-signup`/`.cta-signup-note` are additive modifier classes (on top of the `.hero-signup`/`.hero-signup-note` base classes) that just add `margin: 0 auto` to center the form in the Final CTA's centered layout.
- `privacy.html` has a "Website Launch Signup" section disclosing this data use — keep it in sync if the signup mechanism changes.
- This exact pattern is saved as a reusable recipe named **`sheet-signup`** for reuse on other static sites — ask if it should be replicated elsewhere.

---

## Mobile-only CSS (at bottom of styles.css)

All mobile fixes are in three media query blocks at the end of `styles.css`:

- `@media (max-width: 859px)` — hero flex/order layout (see Hero grid above)
- `@media (min-width: 860px)` — hero desktop 2-col/3-row grid
- `@media (max-width: 640px)` — all other mobile fixes:
  - Comparison cards: tighter padding
  - `.h-lg` bumped to `2.3rem`, `.hero-headline` bumped to `3rem`
  - Banner CTAs (`gs-banner`, `quad-callout`) buttons **centered** (`align-self: center`) — was right-aligned originally, changed per user request
  - How It Works steps: CSS grid with number left of title
  - What's Inside: CSS grid with icon left of title
  - Team: 2-column grid
  - Dashboard Showcase: swaps to `vertical-on-concrete.jpg` (via the `<picture>` in the HTML), repositions `.dash-showcase-copy` to top-center, bumps `.dash-showcase-headline` to `3rem`/`padding-top: 57px`

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

// Signup forms — see "Email signup (sheet-signup pattern)" above
function initSignupForm(formId, frameId, noteId) { /* ... */ }
initSignupForm('hero-signup-form', 'hero-signup-frame', 'hero-signup-note');
initSignupForm('final-signup-form', 'final-signup-frame', 'final-signup-note');
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

### What "push" means for this project

When the user says **"push"** (just that word, no further detail), it means the full pipeline, not just `git push`:
1. Commit any pending changes (ask first only if the commit message/scope is ambiguous — otherwise just write a reasonable message and commit)
2. `git push origin main` — verify the active `gh`/git account has write access to `tfowork/pade-site` first (this repo has required switching from a default `AllAgesShows` account to `tfowork` before)
3. Run `./deploy.sh` to actually deploy to Vercel production and alias `trypade.com`/`trypade.app`

Do all three without re-confirming each step — the user has already approved this full flow for this project. Only pause and ask if something fails (e.g. push rejected, deploy errors) rather than pushing through silently.
