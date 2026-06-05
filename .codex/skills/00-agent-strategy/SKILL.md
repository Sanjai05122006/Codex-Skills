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
