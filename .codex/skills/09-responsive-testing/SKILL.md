---
name: responsive-testing
description: "Verify responsive behavior across mobile, tablet, laptop, desktop, and large screens. Ensures layouts remain visually consistent and usable regardless of device."
---
# Responsive Testing Skill

Runs whenever frontend files are modified.

## Goal

The application must feel native and polished on all devices.

Reference standard:

- Instagram
- Notion
- Stripe
- Linear
- Vercel

The user should have the same experience regardless of:

- iPhone
- Samsung
- OnePlus
- Pixel
- iPad
- Android Tablets
- MacBook
- Windows Laptop
- Ultrawide Monitor

---

## Required Breakpoints

### Mobile

- 320px
- 360px
- 375px
- 390px
- 414px
- 430px

### Tablet

- 768px
- 820px
- 834px
- 1024px

### Desktop

- 1280px
- 1440px
- 1728px
- 1920px

---

## Navbar Checks

- Logo remains visible
- Navigation remains usable
- Mobile menu functions correctly
- No overlap between navigation items
- Avatar menu remains accessible
- Sign In / Sign Up remain visible

---

## Form Checks

- Login page responsive
- Register page responsive
- Forgot password responsive
- OTP verification responsive
- No input overflow
- No button overflow

---

## Layout Checks

- No horizontal scrolling
- No clipped content
- No overflowing cards
- No overflowing tables
- No overlapping elements
- No hidden buttons

---

## Typography Checks

- Text remains readable
- Headings scale appropriately
- Paragraph width remains readable
- No text clipping

---

## Image Checks

- Images remain responsive
- next/image used where applicable
- No stretched images
- No cropped critical content

---

## Dashboard Checks

- Sidebar collapses correctly
- Mobile navigation available
- Tables remain usable
- Cards stack correctly

---

## Validation Rules

FAIL IF:

- Horizontal scrollbar appears
- Layout breaks on any breakpoint
- Navbar becomes unusable
- Auth pages break
- Text overlaps
- Buttons become inaccessible

PASS ONLY IF:

All breakpoints render correctly.
