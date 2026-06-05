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
