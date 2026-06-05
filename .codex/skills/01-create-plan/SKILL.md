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
