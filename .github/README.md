# `.github/` — Copilot Customisation

This directory contains all GitHub Copilot customisation assets: global instructions, scoped instructions, skills, and agents.

## Directory Structure

```text
.github/
├── copilot-instructions.md        # Global instructions (always loaded)
├── instructions/                  # Scoped instructions (loaded when applyTo matches)
├── instructions-inactive/         # Parked instructions (invisible to Copilot)
├── skills/                        # Active skills (description always in context)
├── skills-inactive/               # Parked skills (invisible to Copilot)
├── agents/                        # Active agents (invoked via @agent-name)
└── agents-inactive/               # Parked agents (invisible to Copilot)
```

## Active vs Inactive

Copilot only scans `instructions/`, `skills/`, and `agents/`. The `*-inactive/` directories are **completely invisible** to Copilot — assets stored there consume zero tokens and are never loaded.

This allows keeping all reusable assets versioned in one place while only activating the ones relevant to the current repository.

### Activate an asset

```bash
# Skill
mv .github/skills-inactive/chrome-devtools .github/skills/

# Instruction
mv .github/instructions-inactive/playwright-typescript.instructions.md .github/instructions/

# Agent
mv .github/agents-inactive/my-agent.agent.md .github/agents/
```

### Deactivate an asset

```bash
mv .github/skills/chrome-devtools .github/skills-inactive/
```

## Token Cost Reference

| Asset type                               | When loaded                             | Cost               |
| ---------------------------------------- | --------------------------------------- | ------------------ |
| `copilot-instructions.md`                | Every interaction                       | Fixed, unavoidable |
| `instructions/*.instructions.md`         | When `applyTo` glob matches active file | Fixed per match    |
| `skills/*/SKILL.md` (name + description) | Every interaction                       | ~50 tokens each    |
| `skills/*/SKILL.md` (body)               | Only when skill is triggered            | On-demand          |
| `agents/*.agent.md`                      | Only when user invokes `@agent`         | On-demand          |
| `*-inactive/*`                           | **Never**                               | **Zero**           |

## Setup for New Projects

Run `./bin/setup-project.sh` to copy all assets into a target project's `.github/` directory. Assets are placed in `*-inactive/` by default so you can cherry-pick which ones to activate.
