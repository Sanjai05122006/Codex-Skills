---
name: security-review
description: "Security review for every task without exception. OWASP Top 10, Supabase RLS, Zod boundary enforcement, JWT validation, PII handling, multi-tenant isolation, audit logging for B2B/B2G compliance."
---
# Security Review Skill

Runs on EVERY task — even if only frontend files changed.

## OWASP Top 10 — Check Relevant Items

### A01 Broken Access Control
- [ ] No Express route bypasses Supabase JWT middleware
- [ ] Role checks use only can(role, action, resource) — no inline string comparisons
- [ ] Multi-tenant: every Supabase query scoped to org_id / user auth.uid()
- [ ] RLS enabled on all tables — verified in 04-database-verify if migration ran

### A02 Cryptographic Failures
- [ ] PII columns encrypted at rest (see docs/schema/pii-fields.md)
- [ ] No sensitive data in query strings or URL paths
- [ ] Supabase service role key not exposed to client bundle
- [ ] JWT secret not hardcoded — environment variable only

### A03 Injection
- [ ] All Supabase queries use the SDK's parameterized API — no raw SQL string interpolation
- [ ] All user input passes through Zod before reaching service or repository

### A05 Security Misconfiguration
- [ ] No debug/dev-only routes reachable in production
- [ ] CORS configured restrictively — not origin: '*'
- [ ] HTTP security headers present (helmet or equivalent)
- [ ] Supabase anon key only used for public/anon operations

### A07 Auth Failures
- [ ] Supabase JWT expiry respected — no long-lived tokens without refresh
- [ ] Failed auth attempts logged (without logging the token/password)
- [ ] OTP and password-reset flows have rate limiting
- [ ] Deleting a Supabase user → sessions revoked first

### A09 Logging Failures
- [ ] No passwords, tokens, or PII in any Pino log statement
- [ ] Audit log written for: login, logout, role change, data export, record delete

## Supabase-Specific Security
- [ ] service_role key never in client-side code or Next.js client component
- [ ] RLS policies cover SELECT, INSERT, UPDATE, DELETE as appropriate
- [ ] Storage bucket policies restrict access to owner or role
- [ ] Auth hooks (if used) do not expose user data to other tenants

## B2B / B2G Specific
- [ ] All queries returning user data are tenant-scoped
- [ ] Data export paths have audit log entries
- [ ] Any feature processing government/regulated data: flag for human review before deploy

PASS: all checks clear. If any B2G-flagged item → stop, report, do not auto-proceed.
