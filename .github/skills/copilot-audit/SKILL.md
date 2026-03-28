# Copilot Setup Audit & Optimization

Audit the `.github/` directory structure to detect misconfigurations, duplicates, token waste, and misplaced assets across agents, instructions, skills, and global Copilot instructions. Propose and optionally apply fixes.

## Context: How Token Cost Works

| Asset type                               | When loaded into context                    | Token cost               |
| ---------------------------------------- | ------------------------------------------- | ------------------------ |
| `copilot-instructions.md`                | Every interaction                           | Fixed, unavoidable       |
| `instructions/*.instructions.md`         | When `applyTo` glob matches the active file | Fixed for matching files |
| `skills/*/SKILL.md` (name + description) | Every interaction (~30 words each)          | Low but cumulative       |
| `skills/*/SKILL.md` (body)               | Only when Copilot triggers the skill        | On-demand                |
| `agents/*.agent.md`                      | Only when user explicitly invokes `@agent`  | On-demand, explicit      |

## Procedure

### Step 1 — Discover all assets

Scan the repository for Copilot customization assets:

```
.github/copilot-instructions.md          (global instructions)
.github/instructions/*.instructions.md   (scoped instructions)
.github/skills/*/SKILL.md                (skills)
.github/agents/*.agent.md                (agents)
```

For each asset, collect:

- File path and line count
- YAML frontmatter fields (description, applyTo, excludeAgent, tools, etc.)
- First 10 lines of body content (to understand purpose)

### Step 2 — Run checks

Run every check below against the collected assets. Track issues in a structured list with severity levels.

#### 2.1 Frontmatter validation

- **Instructions** MUST have: `description`, `applyTo`
- **Skills** MUST NOT have YAML frontmatter (SKILL.md uses H1 title + first paragraph as metadata)
- **Agents** MUST have: `description`, `tools` (array)
- Flag unknown/unsupported frontmatter fields (e.g., `excludeAgent` is not in the official spec)
- Flag empty or missing `description` values

#### 2.2 Duplicate and overlap detection

- Compare all asset descriptions pairwise for semantic similarity (>70% overlap in purpose)
- Check for agents that duplicate skills (same function, agent adds no tool restriction value)
- Check for skills that duplicate instructions (skill just provides passive rules, never produces output)
- Flag any two assets that would trigger on the same user prompt with the same result

#### 2.3 Token waste analysis

- Flag instructions with `applyTo: "**"` or `applyTo: "*"` — these load on EVERY file
- Flag instructions longer than 200 lines (high fixed cost when they match)
- Flag `copilot-instructions.md` longer than 150 lines
- Count total "always-on" token budget: `copilot-instructions.md` lines + sum of all skill descriptions (~30 words × N skills) + any `applyTo: "**"` instructions
- Flag skills with descriptions longer than 50 words (description is always in context)

#### 2.4 Misplaced asset detection

Apply the golden rule:

- **Instruction** = passive rules that silently modulate behavior on matching files. Never produce output.
- **Skill** = active procedure that produces concrete output when triggered. Creates files, generates content, performs workflows.
- **Agent** = restricted execution context. Value comes from limiting tools/behavior, not from the task itself.

Flag:

- Skills that contain only rules/conventions and never produce output → should be instructions
- Instructions that describe step-by-step workflows producing output → should be skills
- Agents that don't restrict tools or behavior beyond what a skill would → redundant, merge into skill

#### 2.5 applyTo pattern quality

- Check that `applyTo` globs are as narrow as possible
- Flag patterns that match files where the instruction is irrelevant
- Flag instructions without `applyTo` (they won't activate on any file)
- Suggest tighter patterns when possible (e.g., `**` → `**/*.sh,**/*.bash` for shell-specific rules)

#### 2.6 Skill description quality

- Description must contain trigger phrases users would actually say
- Description must say "Use this skill when..." with concrete examples
- Description should mention what NOT to use it for (to avoid false triggers)
- Flag vague descriptions like "Comprehensive guide for..." or "Best practices for..."

### Step 3 — Generate report

Present findings in a structured table:

```markdown
## Audit Results

### 🔴 Critical Issues (fix immediately)

| #   | Asset | Issue | Recommendation |
| --- | ----- | ----- | -------------- |

### 🟡 Important (should fix)

| #   | Asset | Issue | Recommendation |
| --- | ----- | ----- | -------------- |

### 🟢 Suggestions (nice to have)

| #   | Asset | Issue | Recommendation |
| --- | ----- | ----- | -------------- |

### ✅ Healthy Assets

| Asset | Type | Status |
| ----- | ---- | ------ |

### Token Budget Summary

| Category                               | Count    | Est. words always in context |
| -------------------------------------- | -------- | ---------------------------- |
| copilot-instructions.md                | 1        | X words                      |
| Skill descriptions (metadata)          | N skills | ~30 × N words                |
| Always-on instructions (applyTo: \*\*) | N        | X words                      |
| **Total always-on budget**             |          | **X words**                  |
```

### Step 4 — Propose fixes

For each issue found, propose a specific fix:

- For misplaced assets: show the migration (e.g., "move skill X to instruction with this frontmatter")
- For duplicates: show which to keep and which to delete
- For token waste: show the tighter `applyTo` pattern or suggest splitting
- For bad frontmatter: show the corrected YAML

### Step 5 — Apply fixes (with confirmation)

Ask the user which fixes to apply. Group them by severity. Apply only after explicit confirmation.

Never delete files without user approval. For migrations (skill → instruction), create the new file first, then ask before deleting the old one.
