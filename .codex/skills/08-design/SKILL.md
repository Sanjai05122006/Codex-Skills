---
name: design
description: "Enforce the frontend design system, premium SaaS UX standards, responsive behavior, typography, spacing, authentication layouts, navbar/footer patterns, and Tailwind-based UI consistency."
---

# Frontend Design System

# Design Skill

Read:

docs/ui/design-system.md

All generated UI must follow that document.

If there is a conflict between generated code and the design system, the design system wins.

## Purpose

This skill defines the frontend design standards for all projects built using:

* Next.js
* React
* TypeScript
* Tailwind CSS
* Supabase Authentication

The goal is to produce premium SaaS applications with a consistent design language, strong responsiveness, clean typography, and production-ready user experience.

---

# Core Design Philosophy

Generate interfaces similar in quality to:

* Linear
* Stripe
* Vercel
* Notion
* Raycast

Primary design references:

* Godly UI
* Design Directory
* 21st.dev
* React Bits
* shadcn/ui
* Refactoring UI
* Laws of UX

Avoid:

* Generic AI-generated layouts
* Bootstrap-looking interfaces
* Material UI appearance
* Excessive gradients
* Heavy shadows
* Glassmorphism
* Crowded layouts
* Unnecessary icons
* Random spacing

Every page should feel like a funded SaaS product.

---

# Generated Files

Never modify:

* .next/**
* node_modules/**
* dist/**
* build/**
* coverage/**
* .vercel/**

These are generated artifacts.

Always locate and modify source files.

If a generated file changes unexpectedly:

1. Find the originating source file.
2. Modify the source file.
3. Rebuild the application.

Never edit chunk files.

---

# Typography Standards

## Headings

Use:

* font-semibold
* tracking-tight

Sizes:

Hero Heading:

* text-5xl
* text-6xl

Section Heading:

* text-3xl
* text-4xl

Card Heading:

* text-xl
* text-2xl

Avoid oversized headings.

---

## Body Text

Use:

* leading-relaxed

Paragraphs must be readable.

Reading width:

* max-w-3xl

Avoid:

* giant text blocks
* cramped spacing

---

# Layout Standards

Application Container:

```tsx
max-w-7xl mx-auto px-4 md:px-6 lg:px-8
```

Content Container:

```tsx
max-w-4xl
```

Reading Content:

```tsx
max-w-3xl
```

Avoid:

```tsx
w-full everywhere
```

---

# Navbar Standard

Navbar must always be positioned at the top.

Structure:

Left:

* Logo

Center:

* Navigation links

Right:

* Authentication section

Navbar height:

```tsx
h-16
```

or

```tsx
h-18
```

Use:

* sticky
* backdrop-blur
* subtle bottom border

---

## Logged Out State

Right section contains:

* Sign In
* Sign Up

Sign Up:

Primary button

Sign In:

Secondary button

---

## Logged In State

Right section contains:

* Rounded avatar

Avatar dropdown:

* Profile
* Settings
* Billing
* Notifications
* Sign Out

Avoid multiple action buttons beside avatar.

---

# Footer Standard

Footer should always contain:

## Product

* Features
* Pricing

## Resources

* Documentation
* Guides

## Company

* About
* Contact

## Legal

* Privacy
* Terms

## Social

* Github
* LinkedIn
* X

Footer should feel spacious.

Avoid dense link walls.

---

# Login Page Standard

Desktop Layout:

60 / 40 split

Left:
60%

Right:
40%

---

## Left Side

Contains:

* Logo
* Product Name
* Headline
* Product Description

Purpose:

Explain what the platform does.

Avoid:

* Icons
* Feature grids
* Marketing cards
* Statistics

Keep clean and professional.

---

## Right Side

Authentication card.

Contains:

* Email
* Password
* Sign In

Social Login:

* Continue with Google

Links:

* Forgot Password
* Create Account

Card Styling:

* rounded-2xl
* border
* subtle shadow

Avoid:

* giant shadows
* flashy gradients
* glassmorphism

---

# Register Page Standard

Must visually match Login Page.

Contains:

* Name
* Email
* Password
* Confirm Password

Authentication:

* Continue with Google
* Create Account

Footer:

Already have an account?

Sign In

---

# Form Standards

Every form must provide:

* Labels
* Validation messages
* Loading state
* Success state
* Error state

Never use placeholders as labels.

---

# Button Standards

Primary:

* Filled

Secondary:

* Outline

Danger:

* Destructive styling

Loading:

* Spinner
* Disabled state

Only one primary CTA per section.

---

# Card Standards

Default Card:

* rounded-xl
* border
* subtle shadow

Avoid:

* excessive shadows
* random colors
* oversized padding

---

# Responsive Standards

Must work correctly on:

Mobile:

* 320px
* 375px
* 390px
* 430px

Tablet:

* 768px
* 834px
* 1024px

Desktop:

* 1280px
* 1440px
* 1920px

No overflow.

No horizontal scrolling.

No broken layouts.

---

# Tailwind Standards

Preferred:

* Tailwind utility classes
* Component abstraction
* Consistent spacing scale

Avoid:

* Inline styles
* Unnecessary CSS files

Use reusable components whenever possible.

---

# Frontend Verification Checklist

Before completing frontend work:

* Navbar follows standard
* Footer follows standard
* Login page follows 60/40 layout
* Register page follows 60/40 layout
* Typography is consistent
* Responsive across all breakpoints
* No overflow issues
* No layout shifts
* No .next files modified
* TypeScript passes
* Lint passes
* Build passes

Frontend work is not complete until all checks pass.
