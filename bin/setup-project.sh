#!/usr/bin/env bash

set -e

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DOTFILES_BASE_DIR="$(dirname "${SCRIPT_DIR}")"

source "${SCRIPT_DIR}/lib/constants.sh"

# Get project base path
read -p "Enter project base path: " project_base_path
if [[ ! -e "${project_base_path}" ]]; then
    echo "❌ Project path does not exists"
    exit 1
fi

if [[ ! -f "${project_base_path}/package.json" ]]; then
    echo "⚠️ No package.json found, skipping dependency installation. Run \`npm init\` and re-run this script to install dependencies and setup configuration files."
    exit 1
fi

cd "${project_base_path}"

# Install NodeJS deps
echo "📦 package.json found, installing dependencies..."
for dep in "${NODEJS_DEV_DEPS[@]}"; do
    if npm i -D "$dep" >/dev/null 2>&1; then
        echo "🟢 $dep installed"
    else
        echo "🔴 $dep not installed (error during installation)"
    fi
done

# Setup husky
if [[ ! -d ".husky" ]]; then
    npx husky init
fi

# Copy husky hooks
cp "${DOTFILES_BASE_DIR}/coding/.husky/commit-msg" .husky/commit-msg
cp "${DOTFILES_BASE_DIR}/coding/.husky/pre-commit" .husky/pre-commit
cp "${DOTFILES_BASE_DIR}/coding/.commitlintrc.ts" .
cp "${DOTFILES_BASE_DIR}/coding/.lintstagedrc.js" .
cp "${DOTFILES_BASE_DIR}/coding/.editorconfig" .
cp "${DOTFILES_BASE_DIR}/coding/.prettierrc_with_plugins" ./.prettierrc
cp "${DOTFILES_BASE_DIR}/coding/.prettierignore" .
cp "${DOTFILES_BASE_DIR}/coding/markdownlint.json" ./.markdownlint.json

# read -p "Does this project use PHP? (y/N): " use_php
# if [[ "$use_php" == "y" || "$use_php" == "Y" ]]; then
#     cp "${DOTFILES_BASE_DIR}/coding/phpstan.neon" .
#     cp "${DOTFILES_BASE_DIR}/coding/pint.json" .
# fi

echo "✅ Project setup complete!"
