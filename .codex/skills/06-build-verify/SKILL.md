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
