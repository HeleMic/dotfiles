---
name: create-github-pull-request-from-specification
description: 'Create a GitHub Pull Request from a specification or implementation plan file, using the repository pull_request_template.md as the PR body structure. Use this skill when the user says "create a PR from this spec", "open a pull request for this plan", "turn this specification into a PR", or wants to create a well-structured pull request based on an existing document.'
---

# Create GitHub Pull Request from Specification

Turn a specification or implementation plan into a well-structured GitHub Pull Request, using the repo's PR template to ensure consistency.

## Workflow

1. **Read the specification** — identify the goal, scope, requirements, and affected files from the spec document.
2. **Read the PR template** — load `.github/pull_request_template.md` to understand the expected PR body structure.
3. **Check for existing PRs** — verify no open PR already exists for the current branch to avoid duplicates.
4. **Create the PR as draft** — use the target branch specified by the user (default: `main`). Write a clear title that summarizes the spec's goal. Fill the PR body by mapping spec content to template sections.
5. **Fill the PR body** — map specification content to template sections:
   - Summary/description from the spec's introduction or goal
   - Changes from the implementation steps or affected files
   - Testing instructions from the spec's testing section
   - Leave checklist items for the author to complete manually
6. **Assign the PR** — assign it to the current user.
7. **Mark ready for review** — switch from draft to ready (unless the user asks to keep it as draft).
8. **Report back** — share the PR URL with the user.

## Title format

Use a concise title that reflects the spec's purpose:

```text
feat(auth): implement JWT refresh token support
refactor(api): restructure endpoint routing
```

Follow the project's commit convention if one exists.

## Tips

- If the spec has phases, mention the current phase in the PR description rather than trying to cover everything.
- When the spec references specific files, cross-check with the actual diff to ensure accuracy.
- If no PR template exists, use a sensible default: Summary, Changes, Testing, Notes.
