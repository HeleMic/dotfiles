---
name: create-implementation-plan
description: 'Create a structured implementation plan for new features, refactoring, package upgrades, architecture changes, or infrastructure work. Use this skill when the user wants to plan before coding — e.g. "create a plan for this feature", "write an implementation plan", "plan out this refactoring", or "how should we approach this migration". Also trigger when the user has a spec and wants to break it into actionable phases.'
---

# Create Implementation Plan

Generate a clear, phased implementation plan that can be followed by humans or AI agents. The plan should break complex work into discrete, trackable steps.

## Workflow

1. **Understand the goal** — read any spec, issue, or context the user provides. Ask clarifying questions if the scope is unclear.
2. **Analyze the codebase** — identify affected files, dependencies, and potential risks.
3. **Draft phases** — break the work into sequential phases, each with a clear goal and measurable completion.
4. **Write the plan** — use the template below. Fill every section with concrete, project-specific content.
5. **Save the file** — in `/plan/` using the naming convention below.

## File naming

- Pattern: `[purpose]-[component]-[version].md`
- Purpose prefixes: `upgrade`, `refactor`, `feature`, `data`, `infrastructure`, `process`, `architecture`, `design`
- Examples: `upgrade-system-command-4.md`, `feature-auth-module-1.md`

## Plan template

```md
---
goal: [Concise title describing the plan's goal]
version: 1.0
date_created: [YYYY-MM-DD]
last_updated: [YYYY-MM-DD]
status: "Planned"
tags: [feature, upgrade, refactor, etc.]
---

# Introduction

![Status: Planned](https://img.shields.io/badge/status-Planned-blue)

[2-3 sentences: what this plan achieves and why it matters.]

## 1. Requirements & Constraints

- **REQ-001**: [Functional requirement]
- **SEC-001**: [Security requirement]
- **CON-001**: [Constraint — e.g. must maintain backward compatibility]

## 2. Implementation Steps

### Phase 1 — [Phase name]

- GOAL-001: [What this phase achieves]

| Task     | Description                                    | Completed | Date |
| -------- | ---------------------------------------------- | --------- | ---- |
| TASK-001 | [Concrete task with file paths where relevant] |           |      |
| TASK-002 | [Another task]                                 |           |      |

### Phase 2 — [Phase name]

- GOAL-002: [What this phase achieves]

| Task     | Description | Completed | Date |
| -------- | ----------- | --------- | ---- |
| TASK-003 | [Task]      |           |      |
| TASK-004 | [Task]      |           |      |

## 3. Alternatives Considered

- **ALT-001**: [Approach considered and why it was rejected]

## 4. Dependencies

- **DEP-001**: [Library, service, or component this plan depends on]

## 5. Affected Files

- **FILE-001**: `path/to/file.ts` — [What changes]
- **FILE-002**: `path/to/other.ts` — [What changes]

## 6. Testing

- **TEST-001**: [Test to verify the feature works]
- **TEST-002**: [Edge case to cover]

## 7. Risks & Assumptions

- **RISK-001**: [Risk and mitigation strategy]
- **ASSUMPTION-001**: [Assumption being made]

## 8. Related Documents

- [Link to spec, issue, or relevant docs]
```

## Status values

Use these in the frontmatter `status` field:

| Status      | Badge color  | Meaning            |
| ----------- | ------------ | ------------------ |
| Planned     | blue         | Not yet started    |
| In progress | yellow       | Work underway      |
| Completed   | bright green | All phases done    |
| On Hold     | orange       | Paused             |
| Deprecated  | red          | No longer relevant |

## Writing guidance

- Each task should be small enough to complete in a single work session. If a task feels too big, break it into subtasks.
- Include specific file paths and function names when you know them — vague tasks like "update the backend" are hard to act on.
- Phases should be independently valuable when possible — if phase 1 is done but phase 2 is delayed, the project should still be in a better state than before.
- List risks honestly. A plan that claims zero risk is less useful than one that acknowledges uncertainty and proposes mitigations.
