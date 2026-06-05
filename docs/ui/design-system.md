# Frontend Design System

## Purpose

This document defines the frontend design standards for all projects.

Stack:

- Next.js
- React
- TypeScript
- Tailwind CSS
- Supabase Auth

---

## Design Philosophy

Build premium SaaS interfaces.

Primary references:

- Linear
- Stripe
- Vercel
- Notion
- Raycast

UI inspiration:

- Godly UI
- Design Directory
- 21st.dev
- React Bits
- shadcn/ui
- Refactoring UI
- Laws of UX

Avoid:

- Bootstrap appearance
- Material UI appearance
- Excessive gradients
- Heavy shadows
- Glassmorphism
- Crowded layouts
- Random spacing
- Generic AI-generated UI

---

## Navbar Standard

### Logged Out

Left:
- Logo

Center:
- Navigation

Right:
- Sign In
- Sign Up

### Logged In

Left:
- Logo

Center:
- Navigation

Right:
- User Avatar

Avatar Menu:

- Profile
- Settings
- Billing
- Notifications
- Sign Out

---

## Authentication Pages

Desktop Layout:

60 / 40 Split

### Left Side (60%)

Contains:

- Logo
- Product Name
- Headline
- Product Description

Avoid:

- Icons
- Feature grids
- Statistics
- Marketing cards

### Right Side (40%)

Contains:

- Email
- Password
- Google Login
- Forgot Password
- Sign In / Register

Card Style:

- rounded-2xl
- subtle border
- minimal shadow

---

## Typography

Headings:

- font-semibold
- tracking-tight

Body:

- leading-relaxed

Hero:
- text-5xl
- text-6xl

Section:
- text-3xl
- text-4xl

Card:
- text-xl
- text-2xl

---

## Layout

Application Width:

- max-w-7xl

Content Width:

- max-w-4xl

Reading Width:

- max-w-3xl

---

## Spacing

Section:

- py-24 desktop
- py-16 mobile

Cards:

- p-6 minimum

Forms:

- space-y-6

---

## Footer

Sections:

- Product
- Resources
- Company
- Legal
- Social

Must be spacious.

Avoid link walls.

---

## Responsive Requirements

Must work correctly on:

Mobile:
- 320px
- 360px
- 375px
- 390px
- 430px

Tablet:
- 768px
- 820px
- 834px
- 1024px

Desktop:
- 1280px
- 1440px
- 1728px
- 1920px

Requirements:

- No horizontal scrolling
- No overflow
- No overlapping elements
- No hidden buttons
- No clipped text

---

## Accessibility

Required:

- Semantic HTML
- Keyboard navigation
- Focus states
- Accessible contrast
- Labels on forms
- Alt text on images

---

## Performance

Required:

- next/image
- next/font

Prefer:

- Server Components

Use Client Components only when required.

Avoid:

- unnecessary useEffect
- unnecessary client rendering

---

## Generated Files

Never modify:

- .next/**
- node_modules/**
- dist/**
- build/**
- coverage/**
- .vercel/**

Always modify source files only.
