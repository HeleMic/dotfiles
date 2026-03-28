# Dotfiles — Copilot Instructions

This repository is a personal macOS dotfiles collection. It centralises shell configuration, Git settings, VS Code preferences, coding standards, and setup scripts into a single repo that bootstraps a development machine via `bin/install.sh`.

## Language

- Respond in Italian unless the context is clearly English (e.g. writing commit messages, code comments, README in English).
- Code comments and documentation content in English.

## Repository structure

```text
bin/              Shell scripts (install.sh, setup-project.sh, lib/)
coding/           Shared standards (Prettier, commitlint, markdownlint, lint-staged)
git/              Git config, global ignore, commit template
iterm2/           iTerm2 themes
oh-my-zsh-custom/ Custom ZSH themes and plugins
vscode/           VS Code settings, extensions, MCP config
zsh/              Shell config (.zshrc, .aliases, .functions, .zprofile, .zshenv)
.github/          Copilot agents, instructions, and skills
```

## Shell scripts

- Target `bash` (`#!/usr/bin/env bash`), not `zsh`, for portability.
- Always `set -e` at the top.
- Use `readonly` for constants: `readonly VAR="value"`.
- Source shared libraries from `bin/lib/` (`constants.sh`, `utility.sh`, `filesystem.sh`).
- Use existing helper functions (`link_file`, `check_command`, `print_section`, `join_by`) instead of reimplementing them.
- Interactive prompts: use `read -p` with emoji-prefixed labels (✅ ⚠️ ❌ ⏭️ ✔).
- Paths: use `$HOME` or `~/.dotfiles`, never hardcoded absolute paths.

## ZSH files

- Aliases go in `zsh/.aliases`, functions in `zsh/.functions`.
- Guard conditional aliases with `command -v`:
  ```bash
  if command -v eza &> /dev/null; then
      alias ls="eza --icons --group-directories-first"
  fi
  ```
- Local overrides (not committed) live in `~/.dotfiles-custom/shell/`.

## Git conventions

- Default branch: `main`.
- Commits follow Conventional Commits (see `coding/.commitlintrc.ts` and `git/.gitmessage` for the full type list).
- Merge strategy: `pull.rebase = false`, `rebase.autoStash = true`.
- Machine-specific Git config goes in `~/.gitconfig.local` (included automatically).

## Code style

- Indentation: 2 spaces for most files, 4 spaces for Python/Java/C#, tabs for Makefile/Go (see `.editorconfig`).
- Line endings: LF always (`end_of_line = lf`).
- Always insert a final newline.
- Prettier for JS/TS/JSON/YAML/CSS formatting (config in `coding/.prettierrc`).
- Markdownlint for Markdown (config in `coding/markdownlint.json`; line length rule MD013 is disabled).

## Homebrew

- All packages are declared in `Brewfile` at the repo root.
- When suggesting new CLI tools, add them to `Brewfile` rather than documenting `brew install` commands.

## VS Code

- Settings in `vscode/settings.json` — format-on-save is enabled, Prettier is the default formatter.
- Extensions list in `vscode/extensions.txt`.
- MCP server configuration in `vscode/mcp.json`.

## File naming

- Kebab-case for scripts and config files (`setup-project.sh`, `markdownlint.json`).
- Dot-prefixed for files that get symlinked to `$HOME` (`.zshrc`, `.gitconfig`, `.aliases`).

## What NOT to do

- Do not add secrets, tokens, or credentials anywhere in this repo — use `~/.gitconfig.local` or environment variables.
- Do not hardcode paths with `/Users/michele` — use `$HOME` or relative paths.
- Do not add node_modules, lock files, or build artifacts.
