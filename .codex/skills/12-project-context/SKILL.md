---

name: project-context
description: "Load and respect project-specific documentation before planning or implementation."
-------------------------------------------------------------------------------------------------

# Project Context Skill

This skill runs before implementation begins.

Its purpose is to ensure project-specific documentation takes precedence over generic workflow rules.

---

# Primary Goal

Understand the project before making changes.

Never assume:

* architecture
* folder structure
* auth flow
* route patterns
* deployment strategy
* database design

Read project documentation first.

---

# Required Reading Order

Before planning or implementation:

1. AGENTS.md
2. ARCHITECTURE.md
3. REQUIREMENTS.md
4. docs/ui/design-system.md
5. docs/schema/schema.md
6. docs/api/api.md

Read additional project documentation if present.

---

# Precedence Rules

When instructions conflict:

Project Documentation
↓
AGENTS.md
↓
ARCHITECTURE.md
↓
REQUIREMENTS.md
↓
Project Skills
↓
Generic Skills

Project-specific instructions always win.

---

# Existing Pattern Rule

Before changing any implementation:

1. Read current implementation.
2. Identify existing patterns.
3. Extend existing patterns.
4. Avoid replacing working systems.

Do not redesign architecture without explicit instruction.

---

# Architecture Discovery

Before modifying code:

Identify:

* frontend framework
* backend framework
* database provider
* authentication provider
* deployment model
* testing strategy

Verify assumptions before implementation.

---

# Folder Ownership Verification

Check:

* protected folders
* approval-gated files
* migration policies
* deployment scripts
* environment files

Do not modify protected files without approval.

---

# Documentation Synchronization

Verify whether documentation updates are required.

Examples:

API changes
→ docs/api/

Schema changes
→ docs/schema/

UI pattern changes
→ docs/ui/

Architecture changes
→ ARCHITECTURE.md

Requirements changes
→ REQUIREMENTS.md

---

# Assumption Prevention

Do not invent:

* routes
* auth flows
* callback URLs
* middleware
* database schemas
* integrations

Verify from the project first.

---

# Multi-Project Compatibility

This repository is intended for:

* SaaS applications
* Internal tools
* Dashboards
* B2B products
* B2G products
* Student projects
* Startup products

Every project may have different conventions.

Always adapt to the project.

Never force template assumptions.

---

# Completion Criteria

PASS only when:

* Project documentation reviewed
* Existing architecture understood
* Existing patterns identified
* Proposed implementation aligns with project conventions

Implementation must follow project context, not generic assumptions.
