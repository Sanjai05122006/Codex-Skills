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
