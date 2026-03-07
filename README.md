# 🛠️ Dotfiles

My personal configuration for macOS, ZSH, and VS Code. This repository centralises all configuration files for a modern, consistent, and reproducible development environment.

## 📁 Repository Structure

```text
.
├── bin/                 # Setup and installation scripts
│   ├── install.sh       # Main bootstrap script
│   └── setup-project.sh # Dev-dependency setup for new projects
├── coding/              # Shared standards (Prettier, ESLint, etc.)
├── git/                 # Git config, global ignore, and commit template
├── oh-my-zsh-custom/    # Custom themes and plugins for Oh My Zsh
├── vscode/              # Settings, extensions, and MCP for VS Code
└── zsh/                 # Aliases, functions, and shell config
```

## 🚀 Quick Install

To install or update the dotfiles on a new machine:

1.  Clone the repository: `git clone https://github.com/your-username/dotfiles.git ~/.dotfiles`
2.  Run the install script:
    ```bash
    cd ~/.dotfiles
    ./bin/install.sh
    ```

### What does the script do?

- Checks system prerequisites (`git`, `zsh`, `eza`, `delta`, etc.).
- Creates symlinks for ZSH and Git configuration files.
- Configures VS Code (settings, MCP, and installs missing extensions).
- Creates `~/.gitconfig.local` for machine-specific overrides (e.g. work email or tokens).

## 🎛️ Local Customisation

Versioned files in this repo should stay generic. For local overrides you don't want to commit, use:

- **Git**: Add your credentials to `~/.gitconfig.local` (created automatically by `install.sh`).
- **Terminal**: Local aliases and functions can be loaded automatically from `~/.dotfiles-custom/shell/` (see `.zshrc` for details).

## 💅 Themes & Fonts

- **Recommended fonts**: JetBrains Mono, Manrope, or Meslo (included in `font/`).
- **iTerm2**: The Solarized Dark Corrected theme is in `iterm2/themes/`. Import it by double-clicking the file after installation.
- **ZSH**: `agnoster` theme (customised in `oh-my-zsh-custom/themes/`).

## 🛠️ Project Tooling

Run `./bin/setup-project.sh` inside a new repository to inject standard linting and formatting dependencies (Husky, Prettier, Lint-Staged, etc.).
