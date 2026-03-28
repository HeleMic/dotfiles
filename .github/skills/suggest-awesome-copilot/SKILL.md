---
name: suggest-awesome-copilot
description: 'Browse and install GitHub Copilot assets (agents, instructions, or skills) from the awesome-copilot repository. Use this skill whenever the user asks to find, add, update, or check for new Copilot agents, instruction files, or skills — even if they just say "are there any new skills?", "find me some good Copilot instructions", "check if my agents are up to date", or "what awesome-copilot stuff applies to my project".'
---

# Suggest Awesome GitHub Copilot Assets

Browse the [github/awesome-copilot](https://github.com/github/awesome-copilot) repository and suggest relevant assets — agents, instructions, or skills — based on the current repository context. Detect what's already installed and flag outdated versions.

## Asset type reference

| Type             | Catalog README                                                                                            | Remote folder                                                                     | Raw URL pattern               | Local folder            | File / structure                                                            |
| ---------------- | --------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- | ----------------------------- | ----------------------- | --------------------------------------------------------------------------- |
| **Agents**       | [README.agents.md](https://github.com/github/awesome-copilot/blob/main/docs/README.agents.md)             | [agents/](https://github.com/github/awesome-copilot/tree/main/agents)             | `.../agents/<filename>`       | `.github/agents/`       | `*.agent.md` — front matter: `description`, `tools`                         |
| **Instructions** | [README.instructions.md](https://github.com/github/awesome-copilot/blob/main/docs/README.instructions.md) | [instructions/](https://github.com/github/awesome-copilot/tree/main/instructions) | `.../instructions/<filename>` | `.github/instructions/` | `*.instructions.md` — front matter: `description`, `applyTo`                |
| **Skills**       | [README.skills.md](https://github.com/github/awesome-copilot/blob/main/docs/README.skills.md)             | [skills/](https://github.com/github/awesome-copilot/tree/main/skills)             | `.../skills/<name>/SKILL.md`  | `.github/skills/`       | folder + `SKILL.md` + optional assets — front matter: `name`, `description` |

Base raw URL: `https://raw.githubusercontent.com/github/awesome-copilot/main/`

## Which type(s) to process

If the user specifies a type (agents, instructions, or skills), process that type only. If unspecified, ask — or process all three if the context makes it clear they want a full audit.

## Process (same for all types)

1. **Fetch remote catalog**: Use `fetch` to get the catalog README for the selected type (URL from table above)
2. **Scan local assets**: List local files/folders in the local folder
   - For agents and instructions: read front matter from each file
   - For skills: read `SKILL.md` front matter from each folder; note any bundled assets
3. **Compare versions**: For each local asset, fetch its remote counterpart via the raw URL pattern and compare content. Classify as:
   - ✅ Up-to-date (exact match)
   - ⚠️ Outdated (content differs — note key differences)
   - ❌ Not installed
4. **Analyze context**: Review repo files, tech stack, and chat history to assess relevance
5. **Present results** in the output table — do NOT install or update yet

After presenting the table, **wait for the user** to request installation or updates.

## Context signals to look for

- Programming languages and frameworks in use
- Project type (web app, API, library, infra)
- Development workflow needs (testing, CI/CD, deployment)
- Cloud providers (Azure, AWS, GCP)
- Topics discussed in the current chat session

## Output format

**Agents / Instructions:**

| Awesome-Copilot Asset    | Description  | Status       | Similar Local Asset | Rationale                    |
| ------------------------ | ------------ | ------------ | ------------------- | ---------------------------- |
| [example.agent.md](link) | What it does | ❌ / ✅ / ⚠️ | local-name or None  | Why relevant or what changed |

**Skills** (add a Bundled Assets column):

| Awesome-Copilot Skill | Description | Bundled Assets | Status | Similar Local Skill | Rationale |
| --------------------- | ----------- | -------------- | ------ | ------------------- | --------- |

## Installation / Update

When the user requests it:

- **Agents / Instructions**: download the file to the local folder using `fetch` or `curl`
- **Skills**: download the entire folder — `SKILL.md` and all bundled assets — to `.github/skills/<name>/`
- Do NOT modify downloaded content
- Use the todo list to track progress for batch operations
