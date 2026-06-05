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
