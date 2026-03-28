#!/usr/bin/env bash

set -e

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DOTFILES_BASE_DIR="$(dirname "${SCRIPT_DIR}")"
readonly START_TIME=$(date +%s)

source "${SCRIPT_DIR}/lib/constants.sh"
source "${SCRIPT_DIR}/lib/utility.sh"

# Copy a file asking for confirmation if destination already exists
copy_file() {
  local src="$1"
  local dest="$2"
  local display="${dest/#$HOME/~}"
  if [[ -e "$dest" ]]; then
    read -p "  ⚠️  ${display} already exists — overwrite? (y/N): " overwrite
    if [[ "$overwrite" != "y" && "$overwrite" != "Y" ]]; then
      echo "  ⏭️  Skipped ${display}"
      return
    fi
  fi
  cp "$src" "$dest"
  echo "  ✔ ${display}"
}

# ────────────────────────────────────────────────
# Banner
# ────────────────────────────────────────────────

echo ""
if command -v lolcat >/dev/null 2>&1; then
  printf "  📁  Project Setup\n  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" | lolcat
else
  echo "  📁  Project Setup"
  echo "  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
fi
echo ""

# ────────────────────────────────────────────────────────────────
# Project path
# ────────────────────────────────────────────────────────────────

read -p "  Project path [${PWD}]: " project_base_path
project_base_path="${project_base_path:-$PWD}"

if [[ ! -e "${project_base_path}" ]]; then
  echo "  ❌ Path does not exist: ${project_base_path}"
  exit 1
fi

cd "${project_base_path}"
echo "  ✔ ${project_base_path}"

# ────────────────────────────────────────────────────────────────
# Node.js dependencies
# ────────────────────────────────────────────────────────────────

if [[ ! -f "${project_base_path}/package.json" ]]; then
  echo ""
  echo "  ⚠️  No package.json found."
  read -p "  → Run npm init now? (y/N): " run_init
  if [[ "$run_init" == "y" || "$run_init" == "Y" ]]; then
    npm init
  else
    echo "  ⚪ Skipping Node.js setup."
  fi
fi

if [[ -f "${project_base_path}/package.json" ]]; then
  print_section "📦  Node.js Dependencies"

  count_ok=0
  count_err=0
  for dep in "${NODEJS_DEV_DEPS[@]}"; do
    if npm i -D "$dep" >/dev/null 2>&1; then
      count_ok=$(( count_ok + 1 ))
    else
      echo "  ❌ Failed to install $dep"
      count_err=$(( count_err + 1 ))
    fi
  done
  echo "  ✔ ${count_ok} packages installed"
  [ "$count_err" -gt 0 ] && echo "  ⚠️  ${count_err} packages failed"

  if [[ ! -d ".husky" ]]; then
    echo ""
    echo "  Initialising Husky..."
    npx husky init >/dev/null 2>&1
    echo "  ✔ Husky initialised"
  fi
fi

# ────────────────────────────────────────────────────────────────
# Config files
# ────────────────────────────────────────────────────────────────

print_section "🔗  Config Files"

if [[ -f "${project_base_path}/package.json" ]]; then
  copy_file "${DOTFILES_BASE_DIR}/coding/.husky/commit-msg"        .husky/commit-msg
  copy_file "${DOTFILES_BASE_DIR}/coding/.husky/pre-commit"        .husky/pre-commit
  copy_file "${DOTFILES_BASE_DIR}/coding/.commitlintrc.ts"         .commitlintrc.ts
  copy_file "${DOTFILES_BASE_DIR}/coding/.lintstagedrc.js"         .lintstagedrc.js
  copy_file "${DOTFILES_BASE_DIR}/coding/.prettierrc_with_plugins" .prettierrc
  copy_file "${DOTFILES_BASE_DIR}/coding/.prettierignore"          .prettierignore
  copy_file "${DOTFILES_BASE_DIR}/coding/markdownlint.json"        .markdownlint.json
fi

copy_file "${DOTFILES_BASE_DIR}/coding/.editorconfig" .editorconfig

# ────────────────────────────────────────────────────────────────
# Git remote
# ────────────────────────────────────────────────────────────────

if [[ -d "${project_base_path}/.git" ]]; then
  print_section "🔀  Git Remote"

  read -p "  → Set up SSH remote (personal key)? (y/N): " setup_git
  if [[ "$setup_git" == "y" || "$setup_git" == "Y" ]]; then
    read -p "  GitHub username/org [HeleMic]: " gh_user
    gh_user="${gh_user:-HeleMic}"
    read -p "  Repository name: " gh_repo
    if [[ -z "$gh_repo" ]]; then
      echo "  ⚠️  No repository name provided — skipping."
    else
      git remote remove origin 2>/dev/null || true
      git remote add origin "git@github.com-personal:${gh_user}/${gh_repo}.git"
      echo "  ✔ git@github.com-personal:${gh_user}/${gh_repo}.git"
    fi
  fi
fi

# ────────────────────────────────────────────────────────────────
# Done
# ────────────────────────────────────────────────────────────────

END_TIME=$(date +%s)
ELAPSED=$(( END_TIME - START_TIME ))

echo ""
if command -v lolcat >/dev/null 2>&1; then
  printf "\n  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n  🎉  Setup complete  ·  %ds\n  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n" "$ELAPSED" | lolcat
else
  echo "  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  printf "  🎉  Setup complete  ·  %ds\n" "$ELAPSED"
  echo "  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""
fi
