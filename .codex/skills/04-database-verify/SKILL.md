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
