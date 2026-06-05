# [PROJECT NAME] — Codex Agent Context

## What This Project Is
[One paragraph: product purpose, customer type — B2B / B2G, scale target]

---

## Tech Stack
| Layer          | Technology                                        |
|----------------|---------------------------------------------------|
| Frontend       | Next.js (App Router, React, TypeScript)           |
| Backend / API  | Node.js + Express + TypeScript                    |
| Runtime valid. | Zod (all API boundaries)                          |
| Database       | Supabase (Postgres)                               |
| Auth           | Supabase Auth (OTP, OAuth, JWT)                   |
| Storage        | Supabase Storage                                  |
| Hosting        | [Vercel / AWS / GCP]                              |
| CI/CD          | [GitHub Actions]                                  |

---

## How to Run
```bash
npm install        # install deps
npm run dev        # start dev server
npm run build      # production build
npm run typecheck  # tsc --noEmit
npm run test       # run all tests
npm run lint       # eslint check
```

---

## Agent Execution Mode
Auto mode — EXCEPT these require explicit human approval before execution:
- Any file under supabase/migrations/
- Any .env* file
- Any scripts/deploy* file
- Any action that edits or renames an existing migration file

---

## Mandatory Agent Pipeline

Every task must run this pipeline in order. No skipping. No reordering.

  00-agent-strategy → 01-create-plan → [write code]
  → 02-frontend-verify  (if Next.js/React files changed)
  → 03-backend-verify   (if Express/API files changed)
  → 04-database-verify  (if supabase/ files changed — APPROVAL GATE)
  → 05-security-review  (every task, no exceptions)
  → 06-build-verify
  → 07-change-summary

If any step fails: stop, report the exact failure, do not proceed.

---

## Folder Ownership Rules

### PROTECTED — explicit instruction required
```
supabase/migrations/    ← permanent, sequential SQL files
.env*                   ← environment variables
scripts/deploy*         ← deployment scripts
docs/decisions/         ← append-only ADRs
```

### SYNC PAIRS — change one, update the other
```
supabase/migrations/  →  docs/schema/schema.md
API route changes     →  docs/api/api.md
New PII column        →  docs/schema/pii-fields.md
New npm package       →  REQUIREMENTS.md dependencies
```
## Existing Pattern Rule

Before changing any implementation:

1. Read existing implementation.
2. Identify current pattern.
3. Extend current pattern.
4. Do not replace working architecture.

Never invent:

- auth flows
- callback URLs
- route structures
- middleware patterns
- database access patterns

Follow existing project conventions.
---

## Supabase Migration Rules

Location: supabase/migrations/
Naming:   NNNN_description.sql  (e.g. 0001_create_users.sql)

- NNNN is 4-digit zero-padded, starts at 0001, increments by 1 — no gaps
- NEVER edit an existing migration file. New change = new file.
- Every migration must open with: -- rollback: [SQL to undo]
- Idempotent where possible (IF NOT EXISTS / IF EXISTS)
- PII column added → update docs/schema/pii-fields.md
- New column on large table without default → use nullable or provide default
- Index on large table → use CREATE INDEX CONCURRENTLY

Seed files: supabase/seed/ — local dev only, freely editable

---

## Architecture Layers (do not cross)

  Route Handler → Middleware → Service → Repository → Supabase

- Routes:       receive request, validate with Zod, call service, return response
- Middleware:   auth (Supabase JWT verify), rate limiting, logging
- Services:     business logic, return Result<T,E> — no HTTP objects, no DB calls
- Repositories: all Supabase queries here only, nowhere else

---

## TypeScript Rules
- strict mode, no any, no @ts-ignore
- Branded types for IDs: type UserId = string & { _brand: 'UserId' }
- Zod schema at every API boundary — validate before entering service layer
- All Zod schemas co-located with the route that uses them
- Result<T,E> pattern for service returns — not thrown errors

## Next.js Rules
- App Router only — no Pages Router
- Server Components by default; 'use client' only when required
- Data fetch in Server Components or Route Handlers — not useEffect + fetch
- next/image for all images, next/font for fonts
- Absolute imports via @/ alias — no relative ../..

## Express / Node.js Rules
- Pino for structured JSON logging — never console.log
- Never log req.body — PII risk
- Zod validates all inputs at route layer before reaching service
- Result<T,E> from services — routes handle both ok and err cases
- No synchronous blocking in request path

## Supabase Rules
- RLS enabled on every table — no exceptions
- Policies use auth.uid() for user-scoped access
- Views must be created with security_invoker = true
- Deleting a user → revoke sessions first, then delete
- Service role key never exposed to client
- All queries through Repository layer only

## Security Rules (B2B / B2G)
- Every route has Supabase JWT middleware
- Role checks: can(role, action, resource) only
- Audit log for: login, logout, role change, data export, delete
- OWASP Top 10 checked on every backend change
- Multi-tenant: every query scoped to org_id

## Testing Rules
- Unit tests co-located: foo.ts → foo.test.ts
- Integration: tests/integration/
- E2E: tests/e2e/
- New route: happy-path + auth-failure tests minimum
- Run npm run test before marking any task done
