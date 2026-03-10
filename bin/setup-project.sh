#!/usr/bin/env bash

set -e

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DOTFILES_BASE_DIR="$(dirname "${SCRIPT_DIR}")"
readonly START_TIME=$(date +%s)

source "${SCRIPT_DIR}/lib/constants.sh"
source "${SCRIPT_DIR}/lib/utility.sh"

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
else
    echo ""
    echo "  ⚠️  No package.json found — skipping Node.js setup."
    echo "     Run \`npm init\` and re-run this script."
fi

# ────────────────────────────────────────────────────────────────
# Config files
# ────────────────────────────────────────────────────────────────

print_section "🔗  Config Files"

if [[ -f "${project_base_path}/package.json" ]]; then
    cp "${DOTFILES_BASE_DIR}/coding/.husky/commit-msg"        .husky/commit-msg
    cp "${DOTFILES_BASE_DIR}/coding/.husky/pre-commit"        .husky/pre-commit
    cp "${DOTFILES_BASE_DIR}/coding/.commitlintrc.ts"         .
    cp "${DOTFILES_BASE_DIR}/coding/.lintstagedrc.js"         .
    cp "${DOTFILES_BASE_DIR}/coding/.prettierrc_with_plugins" ./.prettierrc
    cp "${DOTFILES_BASE_DIR}/coding/.prettierignore"          .
    cp "${DOTFILES_BASE_DIR}/coding/markdownlint.json"        ./.markdownlint.json
    echo "  ✔ .husky/commit-msg"
    echo "  ✔ .husky/pre-commit"
    echo "  ✔ .commitlintrc.ts"
    echo "  ✔ .lintstagedrc.js"
    echo "  ✔ .prettierrc"
    echo "  ✔ .prettierignore"
    echo "  ✔ .markdownlint.json"
fi

cp "${DOTFILES_BASE_DIR}/coding/.editorconfig" .
echo "  ✔ .editorconfig"

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
