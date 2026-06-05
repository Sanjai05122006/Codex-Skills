---
name: supabase-auth
description: "Verify Supabase authentication implementation, session management, OAuth, protected routes, environment security, and auth page compliance."
---
# Supabase Authentication Verification Skill

Runs whenever:

- Login page changes
- Register page changes
- Auth middleware changes
- Session logic changes
- OAuth changes
- Protected route logic changes

---

## Environment Security

FAIL IMMEDIATELY IF:

- .env committed
- .env.local committed
- .env.production committed
- service_role key committed
- access token committed
- refresh token committed

Verify:

- .env exists in .gitignore
- secrets loaded from environment variables
- service role key never exposed to client

---

## Login Page Verification

Verify:

- Email login works
- Password login works
- Validation messages displayed
- Loading states displayed
- Error states displayed

Must contain:

- Email
- Password
- Sign In
- Google Login
- Forgot Password

---

## Register Page Verification

Verify:

- Email signup works
- Password validation works
- Confirm password validation works
- Google signup works

Must contain:

- Name
- Email
- Password
- Confirm Password

---

## Forgot Password Verification

Verify:

- Reset email sent
- Token accepted
- Password reset successful
- Redirect works

---

## Session Management

Verify:

- Session persists on refresh
- Session restored correctly
- Logout clears session
- Expired sessions handled correctly

FAIL IF:

- User remains authenticated after logout
- Session becomes inconsistent

---

## Protected Routes

Verify:

- Auth middleware exists
- Protected pages redirect correctly
- Anonymous users blocked
- Authenticated users allowed

FAIL IF:

- Protected page accessible anonymously

---

## OAuth Verification

Verify:

- Google login works
- Callback works
- Session established
- Logout works

---

## Supabase Client Verification

Verify:

- Browser client used in frontend
- Service role never used in client code
- Environment variables correctly referenced

FAIL IF:

- Service role key appears in frontend code

---

## Hallucination Prevention

Before modifying auth:

Verify against:

- Existing implementation
- Existing route structure
- Existing middleware structure
- Existing Supabase configuration

Do NOT:

- Invent routes
- Invent callback URLs
- Invent auth flows
- Replace working auth patterns

Always extend existing implementation.

---

## Final Validation

PASS ONLY IF:

- Login works
- Register works
- Forgot password works
- Google OAuth works
- Session management works
- Protected routes work
- No secrets exposed
- No env files committed
