---
name: create-agent-instructions
description:
  "Create agent instruction files for a repository: AGENTS.md for general AI
  coding agents AND/OR GitHub Copilot instruction files
  (.github/copilot-instructions.md or .github/instructions/*.instructions.md).
  Use this skill whenever the user asks to create or update agent documentation,
  coding agent instructions, Copilot instructions, copilot-instructions.md,
  custom instructions for GitHub Copilot, or AGENTS.md. Also trigger when the
  user wants to document project conventions for AI assistants, configure how
  Copilot behaves in the repo, or set up instruction files for coding agents."
---

# Create agent instruction files for a repository

You are a code agent. Your task is to create one or more instruction files for
AI coding agents working in this repository. Depending on the user's needs, you
may create:

1. **`AGENTS.md`** — a universal agent context file compatible with 20+ AI
   coding tools (Cursor, Aider, Gemini CLI, etc.), following the open format at
   <https://agents.md/>
2. **GitHub Copilot instruction files** — `.github/copilot-instructions.md` for
   global Copilot behavior, or granular `.github/instructions/*.instructions.md`
   files scoped to specific file patterns

Ask the user which they need (or both), then proceed. When in doubt, create both
— they serve complementary purposes and have no overlap.

---

## Part 1 — AGENTS.md

AGENTS.md is an open format designed to provide coding agents with the context
and instructions they need to work effectively on a project.

## What is AGENTS.md?

AGENTS.md is a Markdown file that serves as a "README for agents" - a dedicated,
predictable place to provide context and instructions to help AI coding agents
work on your project. It complements README.md by containing detailed technical
context that coding agents need but might clutter a human-focused README.

## Key Principles

- **Agent-focused**: Contains detailed technical instructions for automated
  tools
- **Complements README.md**: Doesn't replace human documentation but adds
  agent-specific context
- **Standardized location**: Placed at repository root (or subproject roots for
  monorepos)
- **Open format**: Uses standard Markdown with flexible structure
- **Ecosystem compatibility**: Works across 20+ different AI coding tools and
  agents

## File Structure and Content Guidelines

### 1. Required Setup

- Create the file as `AGENTS.md` in the repository root
- Use standard Markdown formatting
- No required fields - flexible structure based on project needs

### 2. Essential Sections to Include

#### Project Overview

- Brief description of what the project does
- Architecture overview if complex
- Key technologies and frameworks used

#### Setup Commands

- Installation instructions
- Environment setup steps
- Dependency management commands
- Database setup if applicable

#### Development Workflow

- How to start development server
- Build commands
- Watch/hot-reload setup
- Package manager specifics (npm, pnpm, yarn, etc.)

#### Testing Instructions

- How to run tests (unit, integration, e2e)
- Test file locations and naming conventions
- Coverage requirements
- Specific test patterns or frameworks used
- How to run subset of tests or focus on specific areas

#### Code Style Guidelines

- Language-specific conventions
- Linting and formatting rules
- File organization patterns
- Naming conventions
- Import/export patterns

#### Build and Deployment

- Build commands and outputs
- Environment configurations
- Deployment steps and requirements
- CI/CD pipeline information

### 3. Optional but Recommended Sections

#### Security Considerations

- Security testing requirements
- Secrets management
- Authentication patterns
- Permission models

#### Monorepo Instructions (if applicable)

- How to work with multiple packages
- Cross-package dependencies
- Selective building/testing
- Package-specific commands

#### Pull Request Guidelines

- Title format requirements
- Required checks before submission
- Review process
- Commit message conventions

#### Debugging and Troubleshooting

- Common issues and solutions
- Logging patterns
- Debug configuration
- Performance considerations

## Example Template

Use this as a starting template and customize based on the specific project:

```markdown
# AGENTS.md

## Project Overview

[Brief description of the project, its purpose, and key technologies]

## Setup Commands

- Install dependencies: `[package manager] install`
- Start development server: `[command]`
- Build for production: `[command]`

## Development Workflow

- [Development server startup instructions]
- [Hot reload/watch mode information]
- [Environment variable setup]

## Testing Instructions

- Run all tests: `[command]`
- Run unit tests: `[command]`
- Run integration tests: `[command]`
- Test coverage: `[command]`
- [Specific testing patterns or requirements]

## Code Style

- [Language and framework conventions]
- [Linting rules and commands]
- [Formatting requirements]
- [File organization patterns]

## Build and Deployment

- [Build process details]
- [Output directories]
- [Environment-specific builds]
- [Deployment commands]

## Pull Request Guidelines

- Title format: [component] Brief description
- Required checks: `[lint command]`, `[test command]`
- [Review requirements]

## Additional Notes

- [Any project-specific context]
- [Common gotchas or troubleshooting tips]
- [Performance considerations]
```

## Working Example from agents.md

Here's a real example from the agents.md website:

```markdown
# Sample AGENTS.md file

## Dev environment tips

- Use `pnpm dlx turbo run where <project_name>` to jump to a package instead of
  scanning with `ls`.
- Run `pnpm install --filter <project_name>` to add the package to your
  workspace so Vite, ESLint, and TypeScript can see it.
- Use `pnpm create vite@latest <project_name> -- --template react-ts` to spin up
  a new React + Vite package with TypeScript checks ready.
- Check the name field inside each package's package.json to confirm the right
  name—skip the top-level one.

## Testing instructions

- Find the CI plan in the .github/workflows folder.
- Run `pnpm turbo run test --filter <project_name>` to run every check defined
  for that package.
- From the package root you can just call `pnpm test`. The commit should pass
  all tests before you merge.
- To focus on one step, add the Vitest pattern:
  `pnpm vitest run -t "<test name>"`.
- Fix any test or type errors until the whole suite is green.
- After moving files or changing imports, run
  `pnpm lint --filter <project_name>` to be sure ESLint and TypeScript rules
  still pass.
- Add or update tests for the code you change, even if nobody asked.

## PR instructions

- Title format: [<project_name>] <Title>
- Always run `pnpm lint` and `pnpm test` before committing.
```

### Implementation Steps

1. **Analyze the project structure** to understand:
   - Programming languages and frameworks used
   - Package managers and build tools
   - Testing frameworks
   - Project architecture (monorepo, single package, etc.)

2. **Identify key workflows** by examining:
   - package.json scripts
   - Makefile or other build files
   - CI/CD configuration files
   - Documentation files

3. **Create comprehensive sections** covering:
   - All essential setup and development commands
   - Testing strategies and commands
   - Code style and conventions
   - Build and deployment processes

4. **Include specific, actionable commands** that agents can execute directly

5. **Test the instructions** by ensuring all commands work as documented

6. **Keep it focused** on what agents need to know, not general project
   information

## Best Practices

- **Be specific**: Include exact commands, not vague descriptions
- **Use code blocks**: Wrap commands in backticks for clarity
- **Include context**: Explain why certain steps are needed
- **Stay current**: Update as the project evolves
- **Test commands**: Ensure all listed commands actually work
- **Consider nested files**: For monorepos, create AGENTS.md files in
  subprojects as needed

## Monorepo Considerations

For large monorepos:

- Place a main AGENTS.md at the repository root
- Create additional AGENTS.md files in subproject directories
- The closest AGENTS.md file takes precedence for any given location
- Include navigation tips between packages/projects

## Final Notes

- AGENTS.md works with 20+ AI coding tools including Cursor, Aider, Gemini CLI,
  and many others
- The format is intentionally flexible - adapt it to your project's needs
- Focus on actionable instructions that help agents understand and work with
  your codebase
- This is living documentation - update it as your project evolves

When creating the AGENTS.md file, prioritize clarity, completeness, and
actionability. The goal is to give any coding agent enough context to
effectively contribute to the project without requiring additional human
guidance.

---

## Part 2 — GitHub Copilot instruction files

GitHub Copilot supports custom instructions that steer Copilot's behavior in
chat, code completions, and code reviews. There are two levels:

| File                                     | Scope                                                                                 | Trigger                                                                |
| ---------------------------------------- | ------------------------------------------------------------------------------------- | ---------------------------------------------------------------------- |
| `.github/copilot-instructions.md`        | Always active — applies to every Copilot interaction in this repo                     | User asks for global/project-wide Copilot instructions                 |
| `.github/instructions/*.instructions.md` | Scoped — applies only to files matching the `applyTo` glob pattern in the frontmatter | User wants instructions for a specific language, framework, or context |

### When to create which file

- **Global instructions** (`.github/copilot-instructions.md`): project-wide
  conventions, architecture decisions, security rules, team preferences that
  apply regardless of language or file type.
- **Scoped instructions** (`.github/instructions/*.instructions.md`): language-
  or framework-specific guidelines (e.g. React component conventions, Python
  type-hint rules, SQL query style) that should only activate for relevant
  files.

Use both when the project has both cross-cutting conventions and
language-specific rules.

### Frontmatter for scoped instruction files

Every `.github/instructions/*.instructions.md` file requires YAML frontmatter:

```yaml
---
description: "Brief description of what these instructions cover"
applyTo: "**/*.ts,**/*.tsx"
---
```

- `description` — shown to the user in the Copilot UI; also used by Copilot to
  decide relevance.
- `applyTo` — a comma-separated list of glob patterns. Use `**` for all files.

The global `.github/copilot-instructions.md` file has **no frontmatter** — it's
plain Markdown.

### What to include in Copilot instruction files

Focus on instructions that change or constrain Copilot's output. Avoid repeating
general knowledge Copilot already has.

Good candidates:

- Project-specific naming conventions and folder structure
- Preferred libraries/frameworks and banned alternatives
- Required code patterns (e.g. "always use `const` over `let`", "use Zod for
  schema validation")
- Testing requirements and frameworks
- Security rules (e.g. "never expose PII in logs", "use parameterized queries")
- Error handling patterns
- Code review criteria

Avoid:

- Standard language syntax Copilot already knows
- Overly long prose — keep instructions concise and directive
- Duplicating content already in README.md verbatim

### Content style for instructions

Write instructions in the **imperative form**, directly addressing Copilot:

```markdown
- Use `pnpm` as the package manager, never `npm` or `yarn`.
- Prefer named exports over default exports.
- Always add JSDoc comments to public functions.
- Use `React.FC` with explicit prop interfaces, never `React.Component`.
```

Group related rules under `##` headings. Keep each instruction to one line where
possible.

### Example: global Copilot instructions file

```markdown
# Project coding conventions

## Architecture

- This project follows a hexagonal (ports and adapters) architecture.
- Business logic lives in `src/domain/`, infrastructure in `src/infra/`.
- Never import infrastructure modules from domain modules.

## Stack

- Runtime: Node.js 20, TypeScript 5
- Package manager: pnpm
- Testing: Vitest for unit tests, Playwright for e2e

## Style

- Use `const` by default; only use `let` when reassignment is required.
- Prefer `async/await` over promise chains.
- All errors must be wrapped and re-thrown with context; no silent `catch`
  blocks.

## Security

- Never log user PII (email, names, IDs) at debug level.
- Validate all external inputs with Zod at the boundary.
- Use parameterized queries; never concatenate SQL strings.
```

### Example: scoped instruction file for TypeScript/React

```markdown
---
description: "Conventions for React components and hooks"
applyTo: "**/*.tsx,src/hooks/**/*.ts"
---

## React conventions

- Define props with a named `interface` directly above the component.
- Use `React.FC<Props>` for all function components.
- Never use class components.
- Co-locate component tests next to the component file (`Component.test.tsx`).
- Use `useCallback` and `useMemo` only when the profiler shows a measurable
  benefit — not by default.
- Prefer `clsx` for conditional class names; never build class strings with
  template literals.
```

### Implementation steps for GitHub Copilot files

1. **Analyze the repository** to understand tech stack, languages, frameworks,
   and existing conventions.
2. **Identify existing conventions** from: `README.md`, `eslint.config.*`,
   `.prettierrc`, `tsconfig.json`, `package.json` scripts, and any existing
   docs.
3. **Decide global vs scoped**: group cross-cutting rules into the global file,
   language/framework-specific rules into scoped files.
4. **Check what already exists** in `.github/` to avoid overwriting or
   duplicating content.
5. **Create the files** with clear, directive instructions. Group by topic with
   `##` headings.
6. **Confirm with the user** whether they want the global file, specific scoped
   files, or both.

### Naming convention for scoped files

Use descriptive, lowercase kebab-case names that reflect the scope:

| Purpose                  | File name                                                |
| ------------------------ | -------------------------------------------------------- |
| TypeScript conventions   | `typescript.instructions.md`                             |
| React/TSX components     | `react-components.instructions.md`                       |
| Python style             | `python.instructions.md`                                 |
| SQL and database         | `database.instructions.md`                               |
| Testing (all)            | `testing.instructions.md`                                |
| CI/CD and GitHub Actions | `github-actions-ci-cd-best-practices.instructions.md`    |
| Docker and containers    | `containerization-docker-best-practices.instructions.md` |

---

## Handling corrections and iterative updates

When the user corrects something you did — a wrong convention, an incorrect command, a naming preference — treat that correction as a signal about the project's actual standards. Don't just fix the one line that was called out: scan **all files under `.github/`** (including `copilot-instructions.md` and every `instructions/*.instructions.md`) and propagate the correction wherever it applies.

The reason is consistency: Copilot will read all these files together, and a contradiction between them — say, one file saying `npm` and another saying `pnpm` — creates ambiguity that leads to unreliable suggestions. A single correction should leave the entire `.github/` instruction set in a coherent state.

**What to do when the user makes a correction:**

1. Understand the intent behind the correction, not just the literal change. If the user says "we don't use ESLint, we use Biome", that affects not only the line you wrote but any other references to ESLint, `eslint.config.*`, or ESLint-specific commands across all instruction files.
2. Grep or scan all files under `.github/` for affected mentions.
3. Apply consistent updates everywhere, then briefly tell the user what you changed and in which files.

The same principle applies to additions: if the user asks you to add a rule (e.g., "always use Zod for validation"), check whether any existing instruction files touch that domain and add or align the rule there too, rather than just appending it to one file.

---

## Summary: choosing the right file(s)

| Goal                                                                    | File to create                                                     |
| ----------------------------------------------------------------------- | ------------------------------------------------------------------ |
| Document project for all AI coding agents (Cursor, Aider, Gemini, etc.) | `AGENTS.md`                                                        |
| Set global rules for GitHub Copilot across the whole repo               | `.github/copilot-instructions.md`                                  |
| Set language/framework-specific rules for Copilot                       | `.github/instructions/<topic>.instructions.md`                     |
| All of the above                                                        | All three (no overlap — they serve different audiences and scopes) |
