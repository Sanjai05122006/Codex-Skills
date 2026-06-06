---
name: frontend-verify
description: "Verify Next.js App Router frontend changes for premium SaaS quality: design system token compliance, typography scale, spacing discipline, Server vs Client boundary, Tailwind-only styling, Zod form validation, accessibility, performance patterns for million-user scale, navbar/footer structure, interactive microstates."
---


# Frontend Verification Skill
## Reference Standard
Premium SaaS baseline: Linear (precision + restraint), Vercel (Geist system + interaction density),
Stripe (typography contrast + premium clarity), 21st.dev component patterns (shadcn/ui + Radix UI),
Godly UI curation standards. Laws referenced: Hick's Law, Fitts's Law, Miller's Law,
Jakob's Law, Law of Proximity, Law of Common Region.

---

## 1 — Design System Token Compliance

Every changed component must use CSS custom properties or Tailwind config tokens.
No raw hex values, no arbitrary px values without a token equivalent.

### Typography Scale (enforce exactly — no deviations)
```
Display:   text-5xl md:text-7xl  font-semibold tracking-tight leading-none
H1:        text-4xl md:text-5xl  font-semibold tracking-tight
H2:        text-3xl md:text-4xl  font-semibold tracking-tight
H3:        text-xl  md:text-2xl  font-medium  tracking-tight
H4:        text-lg               font-medium
Body LG:   text-lg  leading-relaxed
Body:      text-base leading-relaxed
Body SM:   text-sm  leading-relaxed text-muted-foreground
Caption:   text-xs  leading-normal  text-muted-foreground
```
- [ ] Heading font: Geist Sans (next/font) OR Inter — one font family for headings, no mixing
- [ ] Body font: Inter (next/font) — 16px base, 1.5–1.625 line-height
- [ ] Mono font: Geist Mono OR JetBrains Mono — code, labels, technical values only
- [ ] Letter spacing on all headings: -0.02em to -0.04em (tight, never default or positive)
- [ ] No font-size or font-family inline styles — Tailwind classes only
- [ ] Text hierarchy is scannable in 3 seconds — Display > H1 > body is visually distinct

### Spacing Scale (8px grid — enforce strictly)
```
Tokens:  4px(1) 8px(2) 12px(3) 16px(4) 20px(5) 24px(6) 32px(8)
         40px(10) 48px(12) 64px(16) 80px(20) 96px(24) 128px(32)
```
- [ ] All padding and margin values fall on the 8px grid (Tailwind: p-2, p-4, p-6, p-8, p-12...)
- [ ] No arbitrary values like p-[13px] or mt-[22px]
- [ ] Section vertical spacing: minimum py-16 (64px) on desktop, py-10 (40px) on mobile
- [ ] Card internal padding: p-6 (24px) minimum
- [ ] Form field spacing: gap-4 (16px) between fields, gap-2 (8px) between label and input

### Color System
- [ ] Uses semantic color tokens: bg-background, text-foreground, text-muted-foreground,
      border, ring, accent, destructive — NOT raw Tailwind colors like bg-gray-100
- [ ] Dark mode: all semantic tokens have dark: variants OR CSS var resolves automatically
- [ ] No more than 2 accent colors used in a single view (Law of Simplicity)
- [ ] Interactive elements have distinct hover AND focus states — not just color change

---

## 2 — Navbar Requirements (premium SaaS standard)

- [ ] Fixed or sticky positioning — does not scroll away on content pages
- [ ] Height: h-14 (56px) minimum — h-16 (64px) for marketing pages
- [ ] Logo on far left, CTAs on far right (Jakob's Law — matches every major SaaS)
- [ ] Max 5–7 nav items (Miller's Law — cognitive limit)
- [ ] Active route clearly indicated — not just underline, use bg + text weight change
- [ ] Mobile: hamburger menu with slide-in sheet (Radix Dialog or shadcn Sheet)
- [ ] Mobile nav closes on route change
- [ ] Keyboard navigable: Tab order logical, Escape closes mobile menu
- [ ] Backdrop blur on scroll: backdrop-blur-sm bg-background/80 — not solid background
- [ ] No layout shift when navbar becomes sticky (use CSS top padding compensation)
- [ ] CTA button in nav uses primary variant — visually heaviest element, draws first eye

---

## 3 — Footer Requirements (scalable app standard)

- [ ] Columnar layout on desktop: brand column left, link groups right (Vercel/Stripe pattern)
- [ ] Brand column: logo + 1-line tagline + social links — nothing more
- [ ] Link columns: 4–5 links max per column, clear column heading in uppercase or semibold
- [ ] Bottom bar: copyright, legal links (Privacy Policy, Terms), separated by border-t
- [ ] Mobile: stacked columns, 2-column grid for link groups
- [ ] No footer on auth pages (login, signup, onboarding) — reduces distraction
- [ ] Footer links: text-sm text-muted-foreground hover:text-foreground transition-colors
- [ ] Footer does NOT repeat the navbar — different links, different purpose

---

## 4 — Interactive Microstates (Linear/Stripe premium standard)

The density is in the behavior, not the pixels. Premium is interaction-dense — every element responds to hover, focus, keyboard, and context.

- [ ] Every interactive element (button, link, card, input) has ALL of:
      - Default state
      - Hover state (color shift + subtle transform or shadow)
      - Focus-visible state (ring-2 ring-ring ring-offset-2 — never remove outline)
      - Active/pressed state (scale-[0.98] or opacity-90)
      - Disabled state (opacity-50 cursor-not-allowed pointer-events-none)
      - Loading state where applicable (spinner + disabled)
- [ ] Transitions: transition-all duration-150 ease-in-out — consistent across all elements
- [ ] No instant color jumps — every state change animated
- [ ] Card hover: hover:shadow-md hover:border-border/80 hover:-translate-y-0.5 transition-all

---

## 5 — Component Patterns (21st.dev / shadcn/ui standard)

- [ ] Buttons follow size hierarchy:
      - Primary: solid bg-primary text-primary-foreground — used once per view max
      - Secondary: outlined border + transparent background
      - Ghost: no border, hover-only background — for low-emphasis actions
      - Destructive: red system color, confirmation required before action
- [ ] Form inputs: consistent h-10 (40px) height, rounded-md, border + ring-offset on focus
- [ ] Modals/Dialogs use Radix Dialog (shadcn Dialog) — not custom divs
- [ ] Toasts/Notifications use sonner or shadcn Toaster — consistent positioning bottom-right
- [ ] Loading states: skeleton loaders (shadcn Skeleton), not spinners for content areas
- [ ] Empty states: icon + heading + body + CTA — never blank whitespace
- [ ] Error states: inline validation under field — never alert() or console.log()

---

## 6 — Layout and Composition Laws

- [ ] Law of Proximity: related elements grouped with consistent gap — unrelated separated by larger gap
- [ ] Law of Common Region: grouped content inside cards or bordered regions, not floating
- [ ] Hick's Law: max 5 primary actions visible at once — secondary actions in menus
- [ ] Fitts's Law: primary CTA buttons minimum h-10 w-full on mobile, h-10 min-w-[120px] on desktop
- [ ] F-pattern / Z-pattern awareness: most important content top-left on desktop
- [ ] Content max-width: max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 (consistent container)
- [ ] Prose max-width: max-w-2xl for body copy — never full-width text on large screens
- [ ] Section rhythm: alternating bg-background / bg-muted for visual breathing room

---

## 7 — Next.js Specific

- [ ] Server Components by default — 'use client' only for event handlers / hooks / browser APIs
- [ ] next/image for every image — width, height, priority on above-fold images
- [ ] next/font for Geist/Inter — no Google Fonts @import in CSS
- [ ] next/dynamic with ssr:false for heavy client components (charts, rich editors, maps)
- [ ] Route-level loading.tsx for page transitions — not global spinner
- [ ] error.tsx present for major route segments
- [ ] metadata exported from every page for SEO (title, description, openGraph)

---

## 8 — Performance (million-user scale)

- [ ] No Client Components that could stay Server Components
- [ ] Lists >50 items use pagination or virtualized scroll — never full array render
- [ ] Images have explicit width/height — no layout shift (CLS)
- [ ] Above-the-fold content has priority={true} on next/image
- [ ] Heavy libraries (charts, date pickers, rich text) loaded with dynamic import
- [ ] No useEffect data fetching — data in Server Components or Route Handlers
- [ ] Fonts: display:swap via next/font — never FOUT

---

## 9 — Accessibility (WCAG 2.1 AA minimum)

- [ ] Color contrast: text-foreground on bg-background minimum 4.5:1 ratio
- [ ] Interactive elements: 44×44px minimum touch target (Fitts's Law + WCAG)
- [ ] All images: descriptive alt text (not "image" or empty on non-decorative images)
- [ ] Focus ring: never removed, always visible — focus-visible:outline-none focus-visible:ring-2
- [ ] Forms: every input has associated label (htmlFor or aria-labelledby)
- [ ] Modals: focus trapped inside, Escape closes, focus returns on close
- [ ] Screen reader: sr-only class for icon-only buttons
- [ ] Reduced motion: respect prefers-reduced-motion for all transitions/animations

---

## 10 — Code Quality

- [ ] No console.log in changed files
- [ ] No inline style={} props — Tailwind only
- [ ] No arbitrary Tailwind values without comment explaining why (e.g. w-[372px] /* matches design spec */)
- [ ] Absolute @/ imports — no relative ../..
- [ ] One component per file, file named same as component
- [ ] No any TypeScript in component props
- [ ] 'use client' directive: only at file top, never nested

---

## 11 — Tests

- [ ] New component: co-located .test.tsx with at minimum render + key interaction tests
- [ ] Run: npm run test — must exit 0

## PASS CRITERIA
All checkboxes clear. Any failure → fix and re-verify before 03-backend-verify or 05-security-review.


