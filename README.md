<div align="center">

<img src="https://img.shields.io/badge/Codex-Skills-6366F1?style=for-the-badge&logoColor=white" alt="Codex Skills" />

# Codex Skills

**Reusable Claude Codex workflow files for full-stack web projects.**

A structured, numbered workflow that guides AI-assisted development from planning to deployment — covering frontend, backend, database, security, and design.

[![Next.js](https://img.shields.io/badge/Next.js-000000?style=flat-square&logo=next.js&logoColor=white)](https://nextjs.org/)
[![TypeScript](https://img.shields.io/badge/TypeScript-3178C6?style=flat-square&logo=typescript&logoColor=white)](https://www.typescriptlang.org/)
[![Supabase](https://img.shields.io/badge/Supabase-3FCF8E?style=flat-square&logo=supabase&logoColor=white)](https://supabase.com/)
[![Express](https://img.shields.io/badge/Express-000000?style=flat-square&logo=express&logoColor=white)](https://expressjs.com/)
[![License](https://img.shields.io/badge/License-MIT-22c55e?style=flat-square)](LICENSE)

</div>

---

## Table of Contents

- [Overview](#overview)
- [Workflow Stages](#workflow-stages)
- [Supported Stack](#supported-stack)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

---

## Overview

**Codex Skills** is a collection of structured workflow instruction files designed for use with **Claude Codex** (AI-assisted development). Each file represents a discrete phase of the development process — from high-level planning all the way through security review and responsive testing.

Drop these files into your project root and let Codex follow a consistent, repeatable process across every feature you build.

**Why use this?**

- Enforces a structured development process on AI-assisted builds
- Prevents common mistakes by validating frontend, backend, database, and security at each stage
- Reusable across any project on the supported stack
- Reduces the need to re-explain context to the AI on every task

---

## Workflow Stages

The workflow is organized as a numbered sequence. Each file corresponds to a specific phase:

| Stage | File | Purpose |
|-------|------|---------|
| `00` | `agent-strategy` | Defines the overall agentic approach and role context |
| `01` | `create-plan` | Generates a structured development plan before writing code |
| `02` | `frontend-verify` | Validates UI components, routing, and state management |
| `03` | `backend-verify` | Reviews API routes, controllers, and business logic |
| `04` | `database-verify` | Checks schema design, queries, and migrations |
| `05` | `security-review` | Audits auth, input validation, and data exposure |
| `06` | `build-verify` | Confirms the project builds cleanly with no errors |
| `07` | `change-summary` | Produces a concise summary of all changes made |
| `08` | `design` | Reviews visual consistency, spacing, and component design |
| `09` | `responsive-testing` | Validates layout across screen sizes and breakpoints |
| `10` | `supabase-auth` | Handles Supabase Auth setup, RLS policies, and OAuth config |

---

## Supported Stack

Codex Skills is optimized for the following technology stack:

**Frontend**

- [Next.js](https://nextjs.org/) (App Router)
- [React](https://react.dev/)
- [Tailwind CSS](https://tailwindcss.com/)

**Backend**

- [Express](https://expressjs.com/)
- [TypeScript](https://www.typescriptlang.org/)
- [Zod](https://zod.dev/) (schema validation)

**Database**

- [Supabase](https://supabase.com/) (PostgreSQL)

**Authentication**

- Supabase Auth
- Google OAuth

---

## Installation

No package manager required. Just copy the workflow files into your project root:

```bash
git clone https://github.com/Sanjai05122006/Codex-Skills.git
cp -r Codex-Skills/. your-project/
```

Or clone directly into your project root:

```bash
cd your-project
git clone https://github.com/Sanjai05122006/Codex-Skills.git .codex-skills
```

---

## Usage

Once the files are in your project, reference them in your Claude Codex session by stage number.

**Example — starting a new feature:**

```
Use 00-agent-strategy to set your role, then follow 01-create-plan before writing any code.
```

**Example — validating a completed feature:**

```
Run 02-frontend-verify, 03-backend-verify, and 04-database-verify before opening a PR.
```

**Example — pre-deployment checklist:**

```
Run 05-security-review and 06-build-verify, then generate 07-change-summary.
```

**Recommended sequence for a full feature:**

```
00 → 01 → 08 → 02 → 03 → 04 → 05 → 06 → 09 → 07
```

> Start with strategy and planning, build with design in mind, verify each layer, then summarize.

---

## Contributing

Contributions and new workflow stages are welcome.

1. **Fork** this repository
2. **Create** a branch: `git checkout -b skill/your-skill-name`
3. **Add** your workflow file following the existing naming convention (`NN-skill-name`)
4. **Commit**: `git commit -m "feat: add NN-skill-name workflow"`
5. **Push**: `git push origin skill/your-skill-name`
6. **Open** a Pull Request with a description of what the skill covers and when to use it

Found a gap in the workflow? [Open an issue](https://github.com/Sanjai05122006/Codex-Skills/issues).

---

## License

This project is licensed under the [MIT License](LICENSE).

---

<div align="center">

---

*Build with structure. Ship with confidence.*

[![GitHub stars](https://img.shields.io/github/stars/Sanjai05122006/Codex-Skills?style=social)](https://github.com/Sanjai05122006/Codex-Skills/stargazers)

<br/>

Made with ❤️ by **[Sanjai](https://github.com/Sanjai05122006)**

</div>
