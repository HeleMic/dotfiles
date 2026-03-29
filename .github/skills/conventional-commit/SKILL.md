---
name: conventional-commit
description: 'Workflow for generating conventional commit messages tailored to the project commitlint configuration. Use this skill whenever the user asks to commit changes, write a commit message, stage and commit files, or needs help crafting a conventional commit — even if they just say "commit this", "create a commit", or "what should my commit message be".'
---

## What this skill does

Generates a conventional commit message that passes your `commitlint` rules, then runs `git commit` for you.

---

## Commitlint rules (from `coding/.commitlintrc.ts`)

| Rule                       | Constraint                                                         |
| -------------------------- | ------------------------------------------------------------------ |
| Header (full first line)   | Max **100 chars**, no leading/trailing whitespace                  |
| Description (subject only) | Max **72 chars**                                                   |
| Scope                      | Recommended (warning if omitted); multiple scopes separated by `,` |
| Body                       | Max **200 chars** per line, **2000 chars** total                   |
| Footer                     | Max **100 chars** per line, **500 chars** total                    |

**Allowed types:**

| Type       | When to use                                              |
| ---------- | -------------------------------------------------------- |
| `feat`     | A new feature                                            |
| `fix`      | A bug fix                                                |
| `docs`     | Documentation-only changes                               |
| `style`    | Formatting, whitespace — no logic change                 |
| `refactor` | Code restructured without adding features or fixing bugs |
| `perf`     | Performance improvement                                  |
| `test`     | Adding or updating tests                                 |
| `ci`       | CI/CD configuration changes                              |
| `chore`    | Maintenance tasks, dependency updates, tooling config    |
| `revert`   | Reverts a previous commit                                |
| `wip`      | Work in progress (incomplete, not ready for review)      |

---

## Workflow

1. Run `git status` to see which files changed.
2. Run `git diff` (or `git diff --cached` if already staged) to understand what changed.
3. Stage files with `git add <files>` if not already staged.
4. Construct the commit message (format below).
5. Run `git commit` — execute it directly, no confirmation needed.

---

## Commit message format

```text
type(scope): short description

Optional body explaining the motivation behind this change.
Wrap lines at 200 chars. Total body: 2000 chars max.

footer: optional — e.g. BREAKING CHANGE: details, or Closes #123
```

Key rules:

- **type**: one of the 11 allowed types above
- **scope**: optional but recommended; use `,` for multiple scopes — e.g. `(auth,api)`
- **description**: imperative mood, no capital first letter, no trailing period, max 72 chars
- **full header** (type + scope + description combined): max 100 chars
- **Breaking changes**: append `!` after type/scope — e.g. `feat(api)!:` — and add `BREAKING CHANGE: <details>` in the footer

---

## Examples

```text
feat(auth): add JWT refresh token support
```

```text
fix(ui,button): correct focus ring on disabled state
```

```text
refactor(parser): simplify token extraction logic

The previous regex was brittle on edge cases.
The new approach relies on the AST directly.
```

```text
chore: update dependencies
```

```text
feat(api)!: rename /users endpoint to /accounts

BREAKING CHANGE: all clients must update the base path from /users to /accounts
```

---

## Validation checklist

Before running `git commit`, verify:

- [ ] Type is one of the 11 allowed types (no `build` — use `chore` instead)
- [ ] Full header ≤ 100 chars
- [ ] Description ≤ 72 chars, imperative mood, no trailing period
- [ ] No leading/trailing whitespace in the header
- [ ] Scope uses `,` as delimiter when listing multiple scopes
- [ ] Body lines ≤ 200 chars, total ≤ 2000 chars
- [ ] Footer lines ≤ 100 chars, total ≤ 500 chars
