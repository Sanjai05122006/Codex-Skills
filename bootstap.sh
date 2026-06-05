#!/usr/bin/env bash
# =============================================================================
# codex-saas-workflow bootstrap
# Drop this file into any new project root and run:  bash bootstrap.sh
# Creates every workflow file + all skill SKILL.md files in one shot.
# Repo to store and reuse: codex-iphone-skills (your personal skills repo)
# =============================================================================

set -e

echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║   codex-saas-workflow bootstrap              ║"
echo "║   Next.js · Node/Express · TypeScript        ║"
echo "║   Zod · Supabase · Scalable SaaS             ║"
echo "╚══════════════════════════════════════════════╝"
echo ""

# ── Directories ──────────────────────────────────────────────────────────────

mkdir -p .codex/skills/00-agent-strategy
mkdir -p .codex/skills/01-create-plan
mkdir -p .codex/skills/02-frontend-verify
mkdir -p .codex/skills/03-backend-verify
mkdir -p .codex/skills/04-database-verify
mkdir -p .codex/skills/05-security-review
mkdir -p .codex/skills/06-build-verify
mkdir -p .codex/skills/07-change-summary
mkdir -p supabase/migrations
mkdir -p supabase/seed
mkdir -p docs/decisions
mkdir -p docs/api
mkdir -p docs/schema

echo "✓  Directories created"

# ── AGENTS.md ─────────────────────────────────────────────────────────────────

cat > AGENTS.md << 'EOF'
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
EOF

echo "✓  AGENTS.md"

# ── REQUIREMENTS.md ───────────────────────────────────────────────────────────

cat > REQUIREMENTS.md << 'EOF'
# Product Requirements — [PROJECT NAME]

## Vision
[What problem, for whom, what outcome]

## Customer Type
- [ ] B2B   [ ] B2G   [ ] Both

## Scale Target
- MAU: [e.g. 1M]      Orgs/Tenants: [e.g. 10,000]

---

## User Roles
| Role   | Description            | Key Permissions   |
|--------|------------------------|-------------------|
| Admin  | Full system access     | All               |
|        |                        |                   |

---

## Core Modules
1. [Module] — [description]

---

## Third-Party Services
| Service        | Purpose                          |
|----------------|----------------------------------|
| Supabase       | DB, Auth, Storage, OTP           |
|                |                                  |

---

## npm Dependencies
[Add as introduced — keeps AGENTS.md lean]
- zod — runtime validation at API boundaries
- pino — structured JSON logging

---

## Compliance
- [ ] GDPR    [ ] SOC 2    [ ] [Gov standard]
- Audit log retention: [X days]
- PII: docs/schema/pii-fields.md
EOF

echo "✓  REQUIREMENTS.md"

# ── AGENT_TASKS.md ────────────────────────────────────────────────────────────

cat > AGENT_TASKS.md << 'EOF'
# Agent Tasks

Codex: read this file at session start. Pick first item under "Ready for Codex".
Run the full pipeline from AGENTS.md before touching any file.

---

## In Progress


---

## Ready for Codex
- [ ] [Task description] — context: REQUIREMENTS.md §[section]


---

## Blocked
- [ ] [Task] — blocked by: [reason]

---

## Done
EOF

echo "✓  AGENT_TASKS.md"

# ── Backlog.md ────────────────────────────────────────────────────────────────

cat > Backlog.md << 'EOF'
# Backlog

Codex checks this when AGENT_TASKS.md is empty.

## Active
- [ ] [Item]

## Archived
EOF

echo "✓  Backlog.md"

# ── ARCHITECTURE.md ───────────────────────────────────────────────────────────

cat > ARCHITECTURE.md << 'EOF'
# Architecture — [PROJECT NAME]

## Layer Map
```
Browser
  └── Next.js (App Router)
        ├── Server Components     → fetch from Supabase directly (server-side)
        ├── Client Components     → interactive UI, Supabase client
        └── Route Handlers        → /api/* thin HTTP layer

Node.js + Express API  (if separate backend service)
  ├── Routes      → Zod validation → call Service
  ├── Middleware  → Supabase JWT auth, rate limit, Pino logging
  ├── Services    → business logic, Result<T,E>
  └── Repositories → all Supabase queries

Supabase
  ├── Postgres     → tables, RLS policies
  ├── Auth         → JWT, OTP, OAuth
  └── Storage      → file buckets with RLS
```

## Multi-Tenancy
[How org_id isolation is enforced — e.g. org_id column + RLS policy]

## Auth Flow
[Supabase Auth → JWT → middleware verifies → role check → service]

## Scaling Notes
- Stateless API — horizontal replica scaling
- Supabase connection pooling via Supavisor
- Edge-cacheable routes use Next.js full-route cache
EOF

echo "✓  ARCHITECTURE.md"

# ── docs stubs ────────────────────────────────────────────────────────────────

cat > docs/schema/schema.md << 'EOF'
# Database Schema
Sync with supabase/migrations/ after every migration.

## Tables

### [table_name]
| Column     | Type        | Nullable | Description          |
|------------|-------------|----------|----------------------|
| id         | uuid        | NO       | Primary key          |
| created_at | timestamptz | NO       |                      |
| org_id     | uuid        | NO       | Tenant isolation key |

## Migration Log
| File                        | Summary       |
|-----------------------------|---------------|
| 0001_initial_schema.sql     |               |
EOF

cat > docs/schema/pii-fields.md << 'EOF'
# PII Fields Register
Update when any column storing personal data is added.

| Table  | Column    | PII Type     | Encrypted | Retention     |
|--------|-----------|--------------|-----------|---------------|
| users  | email     | Contact      | Yes       | Until deletion |
| users  | full_name | Identity     | Yes       | Until deletion |
EOF

cat > docs/api/api.md << 'EOF'
# API Reference
Sync with route files. Updated by 03-backend-verify.

All endpoints require: Authorization: Bearer <supabase_jwt>
Unless marked [PUBLIC].

---

## GET /health [PUBLIC]
Response: { status: "ok" }

---
EOF

echo "✓  docs stubs"

# ── supabase stubs ────────────────────────────────────────────────────────────

touch supabase/migrations/.gitkeep
touch supabase/seed/.gitkeep

echo "✓  supabase stubs"

# =============================================================================
# SKILLS
# =============================================================================

# ── 00-agent-strategy ─────────────────────────────────────────────────────────

cat > .codex/skills/00-agent-strategy/SKILL.md << 'EOF'
---
name: agent-strategy
description: "ALWAYS runs first before any file is touched. Reads project context, identifies affected layers (Next.js, Express, Supabase), flags protected files, and outputs the execution plan."
---
# Agent Strategy Skill

## Step 1 — Load Context
Read in order: AGENTS.md → AGENT_TASKS.md → ARCHITECTURE.md

## Step 2 — Identify Affected Layers
Check which of these the task touches:
- [ ] Frontend: Next.js pages, components, layouts
- [ ] Backend API: Express routes, middleware, services
- [ ] Repository layer: Supabase query files
- [ ] Database: supabase/migrations/ or supabase/seed/
- [ ] Auth/Storage: Supabase Auth or Storage config
- [ ] Shared lib / types / Zod schemas

## Step 3 — Protected File Check
If the task touches any of these → STOP and request approval:
- supabase/migrations/  → "Migration changes require approval. Confirm to proceed."
- .env*                 → "Env file change requires approval."
- scripts/deploy*       → "Deploy script change requires approval."

## Step 4 — Output Strategy Block (before any code is written)

```
TASK: [task name]
AFFECTED LAYERS: [list]
PROTECTED FILES: [none | list + BLOCKED until approved]
VERIFICATION PIPELINE:
  - 02-frontend-verify: [yes/skip]
  - 03-backend-verify:  [yes/skip]
  - 04-database-verify: [yes/skip — approval required]
  - 05-security-review: yes (always)
  - 06-build-verify:    yes (always)
ESTIMATED CHANGES: [file list]
PROCEED: yes / blocked — [reason]
```

Do not write any code until PROCEED: yes is output.
EOF

echo "✓  00-agent-strategy"

# ── 01-create-plan ────────────────────────────────────────────────────────────

cat > .codex/skills/01-create-plan/SKILL.md << 'EOF'
---
name: create-plan
description: "Runs after agent-strategy outputs PROCEED: yes. Produces a written implementation plan before touching any file. Includes files to create/modify, approach, layer compliance, Zod schema plan, migration number if needed, and tests required."
---
# Create Plan Skill

## Output This Block Before Writing Any Code

```
## Implementation Plan

### Task
[Task name]

### Approach
[What you will do and why this approach — 3-5 sentences]

### Files to CREATE
- [path] — [reason]

### Files to MODIFY
- [path] — [what changes and why]

### Files NOT Touching
- [path] — [why it might seem relevant but isn't]

### Zod Schemas
- [schema name] in [file path] — validates: [fields]

### Layer Compliance Check
- Any route making a direct DB call (violates Route→Service→Repo)?  [yes→STOP / no]
- Any service receiving req/res objects?                              [yes→STOP / no]
- Any DB query outside a repository file?                            [yes→STOP / no]
If any violation: redesign before proceeding.

### Supabase RLS Check
- Does any new table need an RLS policy?     [yes → write policy in migration]
- Does any view exist without security_invoker = true?  [yes → fix in migration]

### Migration Required?
[yes/no]
If yes:
  - Next migration number: [NNNN] (check supabase/migrations/ for last file)
  - Proposed filename: NNNN_description.sql
  - Requires human approval before creating file.

### Tests to Write
- [ ] [test description] → [test file path]

### Edge Cases
- [list]

### Definition of Done
- [ ] All tests pass (npm run test)
- [ ] npm run typecheck exits 0
- [ ] npm run lint exits 0
- [ ] npm run build exits 0
- [ ] Paired docs updated per AGENTS.md sync rules
```

Write zero implementation code until this block is fully output.
EOF

echo "✓  01-create-plan"

# ── 02-frontend-verify ────────────────────────────────────────────────────────

cat > .codex/skills/02-frontend-verify/SKILL.md << 'EOF'
---
name: frontend-verify
description: "Verify Next.js App Router frontend changes: Server vs Client Component boundary, TypeScript strict compliance, Zod usage at form boundaries, Tailwind-only styling, accessibility, performance patterns for scale, test coverage."
---
# Frontend Verification Skill

Runs when any Next.js / React file was changed.

## Checklist

### Server / Client Boundary
- [ ] New components are Server Components by default
- [ ] 'use client' added only when: event handlers, hooks, browser APIs needed
- [ ] No data fetching in useEffect — use Server Components or Route Handlers
- [ ] Supabase client-side calls use the browser client, not the service role client

### TypeScript
- [ ] No `any` in changed files
- [ ] No `@ts-ignore` without a comment explaining why
- [ ] All component props typed with interfaces or Zod-inferred types
- [ ] IDs use branded types (UserId, OrgId) — not bare strings

### Zod
- [ ] Form inputs validated with Zod schema before submission
- [ ] Zod schema co-located with the form/component that uses it
- [ ] Server Action inputs validated with Zod at the action boundary

### Styling
- [ ] Tailwind only — no inline style={} props
- [ ] Responsive classes on all layout-level elements (mobile-first)
- [ ] No new global CSS unless explicitly requested

### Performance (million-user scale)
- [ ] next/image for every <img> — not raw img tags
- [ ] next/font for all font loading
- [ ] Heavy client-side components wrapped in next/dynamic with ssr:false
- [ ] Lists over 50 items use pagination or virtualization — not full renders
- [ ] No unnecessary Client Components that could stay Server Components

### Accessibility
- [ ] All buttons and links have accessible labels
- [ ] All images have alt text
- [ ] Form inputs have labels or aria-label
- [ ] Keyboard navigation works for interactive elements

### Code Quality
- [ ] No console.log in changed files
- [ ] Absolute @/ imports only
- [ ] One component per file

### Tests
- [ ] New component has co-located .test.tsx
- [ ] At minimum: renders without crashing + key interaction test
- [ ] Run npm run test — must exit 0

PASS: all checks clear. Any failure → fix and re-run before proceeding to 03.
EOF

echo "✓  02-frontend-verify"

# ── 03-backend-verify ─────────────────────────────────────────────────────────

cat > .codex/skills/03-backend-verify/SKILL.md << 'EOF'
---
name: backend-verify
description: "Verify Node.js Express backend changes: layer boundary compliance, Supabase JWT auth middleware presence, Zod input validation at every route, Result<T,E> error pattern, Pino structured logging, no request body logging, API doc sync, test coverage."
---
# Backend Verification Skill

Runs when any Express route, middleware, service, or repository file changed.

## Checklist

### Layer Boundaries (hard rule — violation = stop and refactor)
- [ ] Routes call services only — no direct Supabase queries in routes
- [ ] Services have no req/res objects — pure business logic
- [ ] Repositories are the only files that call Supabase
- [ ] No cross-layer imports (repo importing service, etc.)

### Supabase JWT Auth
- [ ] Every new route has auth middleware applied
- [ ] Middleware verifies Supabase JWT — not just presence of header
- [ ] Service role key is never used in middleware or routes — only in repositories where needed
- [ ] Public routes documented explicitly in AGENTS.md

### Zod Input Validation
- [ ] Every route validates req.body / req.params / req.query with a Zod schema
- [ ] Validation happens before calling service — invalid input returns 400
- [ ] Zod schema is typed and exported for test reuse

### Error Handling
- [ ] Services return Result<T,E> — they do not throw
- [ ] Routes handle both ok and err Result cases explicitly
- [ ] No unhandled promise rejections — all async routes use try/catch or asyncHandler wrapper
- [ ] Errors returned as structured JSON: { error: { code, message } }

### Logging (Pino)
- [ ] Pino logger used — no console.log
- [ ] No req.body logged anywhere
- [ ] Log format: { level, message, requestId, userId?, ...meta }
- [ ] Sensitive fields (tokens, passwords) never appear in logs

### Performance (million-user scale)
- [ ] No synchronous blocking in request path
- [ ] All DB work in repositories — never inline in routes or services
- [ ] Queries with large result sets have pagination (LIMIT/OFFSET or cursor)
- [ ] New high-frequency endpoints have rate limiting middleware
- [ ] Supabase connection reused via singleton — not re-created per request

### API Doc Sync
- [ ] If route signature changed: update docs/api/api.md
- [ ] New route documented with: method, path, auth, Zod schema summary, response shape

### Tests
- [ ] New route: happy-path integration test + auth-failure test
- [ ] New service function: unit test covering happy path and error path
- [ ] Run npm run test — must exit 0

PASS: all checks clear. Any failure → fix and re-run before 04 or 05.
EOF

echo "✓  03-backend-verify"

# ── 04-database-verify ────────────────────────────────────────────────────────

cat > .codex/skills/04-database-verify/SKILL.md << 'EOF'
---
name: database-verify
description: "Verify Supabase/Postgres changes: sequential NNNN migration naming, rollback comment blocks, no edits to existing migrations, RLS policy on every table, security_invoker on views, schema doc sync, PII register, N+1 detection, large-table safety."
---
# Database Verification Skill

Runs when supabase/migrations/ or repository files changed.
HUMAN APPROVAL REQUIRED before any new migration file is created.

## Pre-Creation: Migration Numbering
1. List supabase/migrations/ sorted by name
2. Find highest NNNN
3. New NNNN = highest + 1, zero-padded to 4 digits
4. Confirm: "Proposed: NNNN_description.sql — approve to create."

## Migration File Checklist
- [ ] Filename: exactly NNNN_description.sql — no gaps, no duplicates
- [ ] Opens with: -- rollback: [exact SQL to undo]
- [ ] No existing migration file was edited — new files only
- [ ] Idempotent: IF NOT EXISTS / IF EXISTS used where applicable
- [ ] RLS enabled on every new table:
      ALTER TABLE public.table_name ENABLE ROW LEVEL SECURITY;
- [ ] RLS policies written for every access pattern needed
- [ ] Views created with: WITH (security_invoker = true)
- [ ] Foreign key columns have explicit indexes
- [ ] Columns used in WHERE / ORDER BY / JOIN have indexes

## Supabase-Specific Safety Rules
- [ ] No supabase db execute command used — it does not exist; use migrations
- [ ] Deleting a user: sessions revoked first, then user deleted
- [ ] Service role key not referenced in migration files
- [ ] Storage bucket policies written if new bucket created

## Schema Doc Sync
- [ ] New table → add to docs/schema/schema.md
- [ ] Column change → update docs/schema/schema.md
- [ ] PII column → add to docs/schema/pii-fields.md with encryption status

## Repository Layer Check
- [ ] All Supabase queries in repository files only
- [ ] Parameterized queries only — no string interpolation with user input
- [ ] No queries inside loops — use batch select or join
- [ ] SELECT * avoided — explicit column list
- [ ] Large result sets have .range() or .limit() applied

## Large-Table Safety (scale check)
- [ ] Adding NOT NULL column without default → use nullable or provide default (avoids table lock)
- [ ] Adding index on large table → CREATE INDEX CONCURRENTLY in migration
- [ ] Migration safe to run on live table with millions of rows? [confirm]

PASS: all checks clear. Any failure → fix before 05-security-review.
EOF

echo "✓  04-database-verify"

# ── 05-security-review ────────────────────────────────────────────────────────

cat > .codex/skills/05-security-review/SKILL.md << 'EOF'
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
EOF

echo "✓  05-security-review"

# ── 06-build-verify ───────────────────────────────────────────────────────────

cat > .codex/skills/06-build-verify/SKILL.md << 'EOF'
---
name: build-verify
description: "Run the full verification pipeline: TypeScript type check, ESLint, tests, then Next.js build. All four must exit 0. Report exact failures. Do not proceed to change summary until all pass."
---
# Build Verification Skill

Runs after all layer verifications and security review pass.

## Pipeline — Run in This Exact Order

```bash
# 1. Type check (catches TS errors not caught by editor)
npm run typecheck
# = tsc --noEmit
# Must exit 0. Fix all type errors before proceeding.

# 2. Lint
npm run lint
# = eslint .
# Must exit 0. Fix all lint errors before proceeding.

# 3. Tests
npm run test
# Must exit 0. All tests pass. Fix failures before proceeding.

# 4. Build
npm run build
# Must exit 0. No build errors or warnings treated as errors.
```

## Output Format

On full pass:
```
BUILD VERIFICATION
──────────────────
Typecheck:  PASS
Lint:       PASS
Tests:      PASS  (X passed, 0 failed)
Build:      PASS

All steps clean. Proceeding to change summary.
```

On any failure:
```
BUILD VERIFICATION
──────────────────
Typecheck:  FAIL
  → [exact error] at [file:line]
Lint:       BLOCKED
Tests:      BLOCKED
Build:      BLOCKED

Fixing before proceeding.
```

Do not output 07-change-summary until all four steps show PASS.
EOF

echo "✓  06-build-verify"

# ── 07-change-summary ─────────────────────────────────────────────────────────

cat > .codex/skills/07-change-summary/SKILL.md << 'EOF'
---
name: change-summary
description: "Final step. Runs only after 06-build-verify shows all PASS. Outputs a structured diff summary: files changed, before/after comparison, improvements made, what was NOT touched, docs updated, pipeline results. Marks task done in AGENT_TASKS.md."
---
# Change Summary Skill

Only runs after build-verify reports all PASS.

## Output This Block

```
## Change Summary — [TASK NAME]
Date: [YYYY-MM-DD]
Task: [from AGENT_TASKS.md]

---

### Files Changed
| File | Type | What Changed |
|------|------|--------------|
| [path] | Modified | [summary] |
| [path] | Created  | [summary] |

---

### Before vs After
[What existed before. What exists now. The concrete difference.]

---

### What Was Improved
- [Specific improvement — e.g. "Zod schema now validates org_id presence before reaching service"]
- [Specific improvement — e.g. "RLS policy added to orders table — queries now tenant-scoped at DB level"]

---

### What Was NOT Touched
- [File/area — reason it was left alone]

---

### Docs Updated
- docs/api/api.md:           [yes / no / n/a]
- docs/schema/schema.md:     [yes / no / n/a]
- docs/schema/pii-fields.md: [yes / no / n/a]
- REQUIREMENTS.md:           [yes / no / n/a]

---

### Verification Pipeline
- 00 agent-strategy:  PASS
- 01 create-plan:     PASS
- 02 frontend-verify: PASS / SKIPPED
- 03 backend-verify:  PASS / SKIPPED
- 04 database-verify: PASS / SKIPPED
- 05 security-review: PASS
- 06 build-verify:    PASS (typecheck · lint · tests · build)

---

### Next Suggested Task
[Next item from Backlog.md if AGENT_TASKS.md is now empty]
```

After outputting this: mark task done in AGENT_TASKS.md
Change:  - [ ] [task]
To:      - [x] [task] — done [YYYY-MM-DD]
EOF

echo "✓  07-change-summary"

# =============================================================================
# ECOSYSTEM SKILLS — install from official sources
# =============================================================================

echo ""
echo "Installing official ecosystem skills..."
echo ""

# Supabase official agent-skills repo
npx skills add supabase/agent-skills 2>/dev/null && echo "✓  supabase/agent-skills installed" \
  || echo "⚠  supabase/agent-skills: install manually → npx skills add supabase/agent-skills"

# Matteo Collina's Node.js skills (Node.js core contributor, Fastify author)
npx skills add mcollina/skills --skill node-best-practices 2>/dev/null && echo "✓  mcollina/node-best-practices installed" \
  || echo "⚠  mcollina/node-best-practices: install manually → npx skills add mcollina/skills --skill node-best-practices"

# Vercel's Next.js / React skills
npx skills add vercel-labs/agent-skills --skill react-best-practices 2>/dev/null && echo "✓  vercel-labs/react-best-practices installed" \
  || echo "⚠  react-best-practices: install manually → npx skills add vercel-labs/agent-skills --skill react-best-practices"

npx skills add vercel-labs/agent-skills --skill frontend-design 2>/dev/null && echo "✓  vercel-labs/frontend-design installed" \
  || echo "⚠  frontend-design: install manually → npx skills add vercel-labs/agent-skills --skill frontend-design"

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║   Bootstrap complete.                                    ║"
echo "║                                                          ║"
echo "║   Files created:                                         ║"
echo "║     AGENTS.md          REQUIREMENTS.md                  ║"
echo "║     AGENT_TASKS.md     Backlog.md   ARCHITECTURE.md     ║"
echo "║     docs/              supabase/                        ║"
echo "║     .codex/skills/00 → 07                               ║"
echo "║                                                          ║"
echo "║   Next steps:                                            ║"
echo "║   1. Fill [brackets] in AGENTS.md & REQUIREMENTS.md     ║"
echo "║   2. Add first task to AGENT_TASKS.md                   ║"
echo "║   3. Run: codex                                          ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""