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
