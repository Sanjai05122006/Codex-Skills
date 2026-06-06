
---
name: ui-testing
description: "Automated browser-driven UI testing using agent-browser. Covers visual regression across breakpoints, interaction state verification (hover/focus/active/disabled/loading), auth and form flows, navigation routing, accessibility audit, design system compliance, and iterative screenshot matching. Industry standard for scalable SaaS applications."
---
# UI Testing Skill

## Tooling
Primary: `agent-browser` (Vercel Labs) — browser automation CLI for AI agents.
Works across: Codex CLI, Claude Code, Cursor, Gemini CLI, GitHub Copilot, Windsurf.

Install (one-time per project):
```bash
npm install agent-browser
npx agent-browser --help        # confirm install
```

Self-updating skill stub:
```bash
npx agent-browser skills install  # adds .codex/skills/agent-browser/ stub
```

---

## Core Workflow Pattern

Every test session follows this exact sequence:

```bash
# 1. Start dev server (if not already running)
npm run dev

# 2. Open the target URL
agent-browser open http://localhost:3000[/route]

# 3. Get interactive snapshot (compact accessibility tree)
agent-browser snapshot -i
# Returns: heading, link, button, input refs — e.g. @e1, @e2, @e3
# ~200-400 tokens vs ~5000 for raw DOM

# 4. Interact using refs
agent-browser click @e2
agent-browser type @e3 "test@example.com"
agent-browser press Tab
agent-browser press Enter

# 5. Capture screenshot
agent-browser screenshot --annotate tests/screenshots/NNNN-[page]-[state].png

# 6. Compare against reference or baseline (see Visual Regression section)

# 7. Close when done
agent-browser close
```

---

## Screenshot Naming Convention

Zero-padded 4-digit number + page tag + state tag:
```
tests/screenshots/
  0001-home-default.png
  0002-home-mobile.png
  0003-login-empty.png
  0004-login-error.png
  0005-dashboard-loaded.png
  0006-dashboard-dark.png
```

Reference images (design baselines) live in:
```
tests/screenshots/ref/
  home-default.png
  login-empty.png
  dashboard-loaded.png
```

---

## Responsive Breakpoints — Test All Three Every Time

Industry standard breakpoints to validate layout behaviour:

```bash
# Mobile (375px — iPhone standard)
agent-browser open http://localhost:3000 --viewport 375x812
agent-browser screenshot tests/screenshots/NNNN-[page]-mobile.png

# Tablet (768px)
agent-browser open http://localhost:3000 --viewport 768x1024
agent-browser screenshot tests/screenshots/NNNN-[page]-tablet.png

# Desktop (1440px)
agent-browser open http://localhost:3000 --viewport 1440x900
agent-browser screenshot tests/screenshots/NNNN-[page]-desktop.png
```

Checks at each breakpoint:
- [ ] No horizontal scroll at any breakpoint
- [ ] Text readable — no overflow, no truncation of critical content
- [ ] Navigation collapses correctly at mobile (hamburger present and functional)
- [ ] Touch targets minimum 44×44px on mobile (WCAG 2.5.5)
- [ ] Card grids reflow: 3-col desktop → 2-col tablet → 1-col mobile
- [ ] Images do not overflow containers
- [ ] Footer columns stack correctly on mobile

---

## Visual Regression — Iterative Match Loop

The industry standard: capture screenshots, compare against baseline, review only flagged diffs. Cover 5–10 highest-traffic pages and critical user flows first.

### When a reference image exists:
```
Loop until match:
  1. agent-browser screenshot tests/screenshots/NNNN-[page].png
  2. Compare screenshot to tests/screenshots/ref/[page].png
  3. Identify diff — layout, spacing, color, typography, component state
  4. Fix the issue in code
  5. Return to step 1
  6. Declare done only when screenshot is a pixel-level match to reference
```

Do NOT declare done if any of these differ from reference:
- Spacing (even a single 4px shift is a regression)
- Typography weight, size, or line height
- Color — including hover state colors
- Component alignment — especially on mobile
- Missing or extra elements

### When no reference image exists (baseline creation):
```
1. Complete all other verification checklist items first
2. Capture baseline screenshots at all 3 breakpoints
3. Store in tests/screenshots/ref/
4. Name them without numbering: [page]-[breakpoint].png
5. Commit baseline to repo — these are the new source of truth
```

---

## Interaction State Verification

Premium SaaS standard: interaction-dense, not pixel-dense. Every element you see is responsive to hover, focus, keyboard, and context.

For every interactive element on changed pages:

### Buttons
```bash
# Default
agent-browser screenshot --annotate tests/screenshots/NNNN-btn-default.png

# Hover — move mouse over button ref
agent-browser hover @e[button-ref]
agent-browser screenshot tests/screenshots/NNNN-btn-hover.png

# Focus — tab to it
agent-browser press Tab  # tab to button
agent-browser screenshot tests/screenshots/NNNN-btn-focus.png
# Verify: focus ring visible (ring-2 ring-ring ring-offset-2)

# Active/Pressed
agent-browser screenshot tests/screenshots/NNNN-btn-active.png
```

Verify for each state:
- [ ] Default: clear affordance, correct variant (primary/secondary/ghost/destructive)
- [ ] Hover: color shift + subtle transform or shadow — not instant jump
- [ ] Focus: visible ring — NEVER invisible. Tab-navigable without mouse.
- [ ] Active/Pressed: scale or opacity feedback
- [ ] Disabled: opacity-50, cursor-not-allowed, no interaction possible
- [ ] Loading: spinner present, button disabled during async operation

### Form Inputs
- [ ] Empty state: placeholder text visible, correct border color
- [ ] Focus state: ring-2 visible, border color change
- [ ] Filled state: text readable, correct contrast
- [ ] Error state: red border + inline error message below field (not alert())
- [ ] Success state: if applicable
- [ ] Disabled state: bg-muted, cursor-not-allowed

### Navigation Links
- [ ] Default: correct text color
- [ ] Hover: transition-colors visible
- [ ] Active/current route: distinct visual treatment (not just underline)
- [ ] Focus: keyboard ring visible

---

## Auth Flow Testing

Test each flow end-to-end in the browser:

### Login Flow
```bash
agent-browser open http://localhost:3000/login
agent-browser snapshot -i

# Test 1: Empty submission
agent-browser click @e[submit-btn]
agent-browser screenshot tests/screenshots/NNNN-login-empty-error.png
# Verify: inline validation errors appear on both fields

# Test 2: Invalid email
agent-browser type @e[email-input] "notanemail"
agent-browser type @e[password-input] "password123"
agent-browser click @e[submit-btn]
agent-browser screenshot tests/screenshots/NNNN-login-invalid-email.png
# Verify: email format error shown

# Test 3: Wrong credentials
agent-browser clear @e[email-input]
agent-browser type @e[email-input] "test@example.com"
agent-browser click @e[submit-btn]
agent-browser screenshot tests/screenshots/NNNN-login-wrong-creds.png
# Verify: server error message shown, no stack trace exposed

# Test 4: Successful login (use test credentials)
agent-browser type @e[email-input] "[TEST_EMAIL]"
agent-browser type @e[password-input] "[TEST_PASSWORD]"
agent-browser click @e[submit-btn]
# Verify: redirects to dashboard, auth state set
agent-browser screenshot tests/screenshots/NNNN-post-login-redirect.png
```

### OTP Flow (Supabase OTP)
```bash
agent-browser open http://localhost:3000/login
# Enter email only
agent-browser type @e[email-input] "[TEST_EMAIL]"
agent-browser click @e[send-otp-btn]
agent-browser screenshot tests/screenshots/NNNN-otp-sent.png
# Verify: OTP input screen shown, success message present
# Verify: countdown timer or resend option visible
```

### Password Reset Flow
```bash
agent-browser open http://localhost:3000/forgot-password
agent-browser type @e[email-input] "test@example.com"
agent-browser click @e[submit-btn]
agent-browser screenshot tests/screenshots/NNNN-forgot-password-sent.png
# Verify: confirmation message shown
# Verify: no user enumeration — same message for unknown email
```

### Protected Route Redirect
```bash
# Without auth
agent-browser open http://localhost:3000/dashboard
agent-browser screenshot tests/screenshots/NNNN-protected-redirect.png
# Verify: redirected to /login, not blank page, not 404, not error
```

---

## Navigation and Routing

```bash
# Test all primary nav links
agent-browser open http://localhost:3000
agent-browser snapshot -i

# Click each nav link, verify:
# - URL changes correctly
# - Page content loads (no blank, no error boundary)
# - Active nav item updates correctly
# - Back button works (browser history)

# Mobile nav
agent-browser open http://localhost:3000 --viewport 375x812
agent-browser click @e[hamburger-btn]
agent-browser screenshot tests/screenshots/NNNN-mobile-nav-open.png
# Verify: menu slides in, backdrop present, close button visible
agent-browser press Escape
agent-browser screenshot tests/screenshots/NNNN-mobile-nav-closed.png
# Verify: menu closes on Escape
```

Checks:
- [ ] All nav links resolve to correct routes — no 404s
- [ ] Active route indicator updates on navigation
- [ ] Mobile hamburger opens and closes correctly
- [ ] Mobile nav closes when a link is clicked (not stuck open)
- [ ] No layout shift on navigation (no FOUC)
- [ ] Loading state shown during route transitions

---

## Accessibility Audit

```bash
# Run accessibility snapshot — checks ARIA roles and structure
agent-browser snapshot --accessibility
```

Verify against WCAG 2.1 AA:
- [ ] Page has one `<h1>` — no skipped heading levels (h1 → h2 → h3)
- [ ] All images have alt text — none empty on non-decorative images
- [ ] All form inputs have associated labels
- [ ] Focus order follows logical reading order (Tab sequence)
- [ ] Focus ring never invisible on any element
- [ ] Color contrast: text on background passes 4.5:1 minimum
- [ ] Icon-only buttons have aria-label or sr-only text
- [ ] Modals: focus trapped inside while open, Escape closes, focus returns on close
- [ ] No keyboard trap anywhere (can always Tab out of any element)
- [ ] ARIA live regions present for dynamic content updates (toasts, alerts)

---

## Design System Compliance Checks

Cross-reference against the project design system (docs/ui/design-system.md or AGENTS.md):

- [ ] Typography: only approved scale used — no rogue font sizes
- [ ] Spacing: 8px grid — no values that fall off the scale
- [ ] Colors: semantic tokens only — no raw hex or raw Tailwind color classes
- [ ] Components: from the design system library — no one-off custom reimplementations
- [ ] Navbar height matches spec (56px or 64px)
- [ ] Container max-width consistent across all pages (max-w-7xl)
- [ ] Dark mode: if supported, verify all pages at dark mode too

```bash
# Dark mode check
agent-browser open http://localhost:3000 --color-scheme dark
agent-browser screenshot tests/screenshots/NNNN-home-dark.png
# Verify: no white boxes, no invisible text, no unthemed elements
```

---

## Pages to Test on Every Significant UI Change

Priority order — test these first:
1. Landing / Marketing home
2. Login page
3. Signup / Register page
4. OTP / verification screen
5. Main dashboard (post-login)
6. Primary feature page(s)
7. Settings / Account page
8. 404 page
9. Error boundary page

Optional (test when relevant feature changes):
- Forgot password / reset flow
- Onboarding flow
- Data tables / lists
- Modal dialogs
- Notification/toast surfaces

---

## What NOT to Use Browser Testing For

- Server-only code logic → use unit/integration tests (npm run test)
- API endpoint correctness → use integration tests with a test DB
- TypeScript type correctness → npm run typecheck
- Purely data-driven pages with no meaningful layout → functional tests only

---

## Pass Criteria

```
BROWSER TEST RESULT
────────────────────────────────────────
Responsive (mobile/tablet/desktop): PASS
Visual regression vs reference:     PASS / BASELINE CREATED
Interaction states (all elements):  PASS
Auth flows:                         PASS
Navigation/routing:                 PASS
Accessibility (WCAG 2.1 AA):        PASS
Design system compliance:           PASS

All checks pass. Proceeding to 06-build-verify.
```

Any failure:
```
BROWSER TEST RESULT
────────────────────────────────────────
Visual regression: FAIL
  → dashboard card grid collapses at 768px — expected 2-col, got 1-col
  → screenshot: tests/screenshots/0012-dashboard-tablet.png
  → reference:  tests/screenshots/ref/dashboard-tablet.png

Fixing before proceeding.
```

Iterate until all checks pass. Do not proceed to 06-build-verify until result is all PASS.
