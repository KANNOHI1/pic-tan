# DESIGN.md — Pic-tan

A children's English-Japanese vocabulary learning app for ages 2–6.
Children study flashcards and befriend animals, who then "move into" a growing town.
Core emotion: **warmth + discovery + ownership**. Like Animal Crossing as a picture book.

---

## 1. Visual Theme

Tactile "felt-world" aesthetic. Feels like a handcrafted toy, not a digital app.
Soft, rounded, cozy — as if every element was cut from felt fabric and placed on a warm surface.
Reference: needle felt dolls, children's picture books, Animal Crossing pastels.

**Tone keywords**: warm / round / soft / playful / trustworthy / gentle

---

## 2. Color Palette

| Role | Name | HEX | Usage |
|---|---|---|---|
| Background | Warm Cream | `#FFF8E7` | App background, screen base |
| Surface | White | `#FFFFFF` | Cards, panels, bubbles |
| Primary CTA | Terracotta | `#E8835A` | Main buttons, highlights, progress |
| Reward | Sunny Yellow | `#FFD166` | Badges, streaks, celebration |
| Friendship | Coral Pink | `#FF8FAB` | Hearts, partner character accent |
| Nature | Sage Green | `#A8D5A2` | Success states, town grass, "knew it!" button |
| Text | Warm Charcoal | `#3D3227` | All body text — never pure black |
| Muted | Warm Gray | `#9A8878` | Secondary text, hints |
| Border | Soft Sand | `#E8DDD0` | Card borders, dividers |

**Rules**:
- Never use pure white `#FFFFFF` as a background — always use `#FFF8E7` (cream)
- Never use pure black — use `#3D3227`
- Terracotta `#E8835A` is the single dominant action color — use sparingly for maximum impact
- Gradients: only cream-to-transparent for overlay panels (never harsh stops)

---

## 3. Typography

| Context | Font | Weight | Size | Notes |
|---|---|---|---|---|
| English (UI) | Nunito | 800–900 | varies | Bouncy, rounded, child-friendly |
| Japanese (UI) | Noto Sans JP | 400–700 | varies | Clear, warm, readable for children |
| English flashcard word | Nunito | 900 | 3rem (48px) | Big, bold, dominant — the child reads this. EN is always dominant. |
| Japanese reading | Noto Sans JP | 700 | 1.75rem (28px) | Below English, secondary. Color: `--muted` (#9A8878), not charcoal. |
| Button labels | Nunito | 900 | 1.4–1.8rem | All caps feel, bold, friendly |
| Body / hints | Noto Sans JP | 400 | 0.9–1rem | Quiet, guiding |
| Section titles | Noto Sans JP | 700 | 1.1–1.15rem | Warm, clear |

**Rules**:
- English text always uses Nunito; Japanese always uses Noto Sans JP
- No thin weights (< 400) anywhere — children need clear, legible type
- Letter-spacing on buttons: `0.04–0.06em` for breathing room
- **Hierarchy rule**: On flashcards, EN is always larger and charcoal; JA is always smaller and muted. Never equalize them.

---

## 4. Component Styling

### Buttons
- **Primary (CTA)**: full-width, 64–72px height, terracotta `#E8835A`, white text, Nunito 900, 16px radius
  - Box shadow: `0 4px 0 #b85a32` — gives a physical "pressable" feel
  - Active: translateY(3px) + shadow collapses — satisfying tactile feedback
- **Disabled**: `#E8DDD0` background, `#9A8878` text — clearly inactive, not gray
- **Rating buttons**: 64px height, half-width, rounded 16px
  - "Knew it 😊": sage green `#A8D5A2`
  - "Hard 😵": cream background, sand border — neutral, not alarming

### Cards
- White background `#FFFFFF` — never transparent
- Border: `2.5px solid #E8DDD0`
- Border-radius: `24px`
- Shadow: `0 6px 24px rgba(61,50,39,0.12)` — warm-toned, gives a physical "felt object" feel
- Image area: square, `aspect-ratio: 1`, `object-fit: contain`, max 220×220px

### Study Card Tap Flow
Three stages — never reveal everything at once:
- **Tap 0** (initial): image only + "こたえは？" hint text
- **Tap 1**: English word appears (3rem, Nunito 900, charcoal) + hint changes to "もういちど →"
- **Tap 2**: Japanese word appears below EN (1.75rem, Noto Sans JP 700, muted) + rating buttons slide in

### Speech Bubbles
- White background, `2px solid #E8DDD0`, `16px` radius
- Triangle pointer: CSS border trick, points toward speaker
- Padding: `14px 18px`
- Font: Noto Sans JP, 1rem, charcoal — friendly, clear

### Partner Characters (in town view)
- Displayed as emoji or felt-doll image at `2.4rem` scale
- Animate in a loop: bounce (rabbit), walk (cat/dog), waddle (penguin), fly (bird)
- Drop shadow: `filter: drop-shadow(0 2px 4px rgba(0,0,0,0.2))`

### Progress Indicator
- Row of dots: `10px` circles
  - Done: terracotta `#E8835A`
  - Current: charcoal `#3D3227`
  - Upcoming: sand `#E8DDD0`

### Parent Panel (overlay)
- Bottom sheet, slides up
- Max height `85dvh`, scrollable
- Rounded top corners `24px`, no bottom radius
- Background: white — clean, adult-facing contrast to the playful child UI

---

## 5. Layout Principles

### Grid & Spacing
- Base unit: `8px`
- Screen max-width: `390px` (centered on wider screens)
- Body padding: `8px` — screen appears as a floating card on cream background
- Internal padding: `16–20px` horizontal, `8–16px` vertical

### Screen Structure
- App appears as a **white rounded card** (`24px` radius) floating on cream background
- Each screen is a single scrollable column — no horizontal navigation
- **Bottom-anchored CTAs**: primary action button always at thumb reach
- Minimum tap target: `44×44px` — no exceptions

### Home Screen (special case)
- Town illustration fills **100dvh** — the image IS the screen
- Controls (speech bubble + CTA button) overlay at the bottom via gradient fade
- Gradient: `transparent → rgba(255,248,231,0.75) → #FFF8E7` — image bleeds into cream naturally

### Card Study Screen
- Progress dots: top center, compact
- Image card: centered, takes ~50% of screen height
- After 2nd tap: English word large above Japanese — hierarchy is clear
- Rating buttons appear below — never obscure the card

### Completion Screen
- Partner + animal emoji large, centered, animated
- Heart floats between them
- Friendship hearts animate in sequence
- CTA at bottom: "またあした！" (See you tomorrow!)

---

## 6. Motion & Animation

| Element | Animation | Duration | Easing |
|---|---|---|---|
| Word reveal (English) | `opacity 0→1, translateY 6px→0` | 150ms | ease-out |
| Word reveal (Japanese) | same, 100ms delay after EN | 150ms | ease-out |
| Card entrance | `scale 0.92→1, opacity 0→1` | 200ms | spring (0.34,1.56,0.64,1) |
| Screen transition | `opacity + translateY 8px→0` | 200ms | ease-out |
| Partner: Rabbit (lulu) | translateY bounce (−16px) | 0.6s | ease-in-out, alternate |
| Partner: Cat (chai) | translateX slow walk | 6s | ease-in-out, infinite |
| Partner: Dog (pochi) | translateY fast bounce (−8px) | 0.4s | ease-in-out, alternate |
| Partner: Penguin (pepe) | rotate ±8deg + translateY | 1s | ease-in-out, alternate |
| Partner: Bird (sora) | translateY small wave | 2s | ease-in-out, infinite |
| Bounce (complete screen) | translateY 0 → -12px | 0.8s | ease-in-out, alternate |
| Heart sequential fill | scale 0→1 per heart | 300ms | ease-out, stagger 120ms |
| Celebration stars | scale 0→1.5, rotate 180deg | 600ms | spring, stagger 80ms |
| Confetti fall | translateY + rotate 720deg | 3s | ease-in, random delay |
| Parent panel slide-up | translateY 100% → 0 | 250ms | ease-out |

**Rules**:
- All animations are CSS-only (no JS animation libraries needed for this scale)
- Nothing flashes or strobes — seizure safety for young children
- Motion should feel physical: buttons press down, cards pop in, characters have personality
- Partner animations are keyed by `[data-partner="..."]` on `<body>` — each partner has a unique keyframe
- `@media (prefers-reduced-motion: reduce)` disables all animations
- Screen transitions use exit (fade-out 200ms) → swap hidden → enter (fade-in 200ms) pattern

## 8. Design System Refinements

Patterns adopted from reference design systems:

**Shadow system** (from Airbnb):
- `--shadow-lift: 0 2px 8px rgba(61,50,39,0.08)` — subtle hover/interactive lift
- `--shadow-card: 0 6px 24px rgba(61,50,39,0.12)` — study card, felt-object depth
- `--shadow-lg: 0 8px 32px rgba(61,50,39,0.14)` — screen container

**Warm paper surface** (from Zapier/Lovable):
- Background is always `#FFF8E7` (warm cream) — never cold white
- Cards use `#FFFFFF` only for contrast against the cream background
- Borders use `#E8DDD0` (warm sand) — craft-like, never cold gray

**Generous radii** (from Airbnb):
- `--radius-lg: 24px` — cards, screen container, parent panel
- `--radius-md: 16px` — buttons, bubbles, partner cards
- 50% for circular elements (parent button, progress dots at active state)

**Spring easing** (custom):
- `cubic-bezier(0.34, 1.56, 0.64, 1)` for entrances that overshoot slightly — satisfying, playful

---

## 7. Image Style Guide

All character and object images follow the **needle felt doll aesthetic**:
- Handcrafted wool/felt texture
- Soft studio lighting (no harsh shadows)
- Plain pastel background (sage green, sky blue, or warm cream)
- Centered composition, square format `1024×1024`
- No text, no logos, no UI chrome in the image
- Child-friendly expressions: round eyes (bead-like), simple smile

**Town illustrations** (background images):
- Flat illustration style, top-down perspective
- Pastel color palette matching app colors
- Progressive detail: barren → flowers → houses → full town
- Aspect ratio: portrait or square (fills mobile screen height)
