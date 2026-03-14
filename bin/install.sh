#!/usr/bin/env bash

set -e

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DOTFILES_BASE_DIR="$(dirname "${SCRIPT_DIR}")"

readonly START_TIME=$(date +%s)

source "${SCRIPT_DIR}/lib/constants.sh"
source "${SCRIPT_DIR}/lib/utility.sh"
source "${SCRIPT_DIR}/lib/filesystem.sh"

# ────────────────────────────────────────────────
# Banner
# ────────────────────────────────────────────────

echo ""
if command -v lolcat >/dev/null 2>&1; then
    printf "  🛠️  Dotfiles Setup\n  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" | lolcat
else
    echo "  🛠️  Dotfiles Setup"
    echo "  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
fi
echo ""

# ────────────────────────────────────────────────────────────────
# Prerequisites
# ────────────────────────────────────────────────────────────────

echo "  Checking prerequisites..."
echo ""

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "  ⚠️  Oh My Zsh not installed (required)"
    read -p "  → Install Oh My Zsh now? (Y/n): " install_omz
    if [[ "$install_omz" != "n" && "$install_omz" != "N" ]]; then
        echo "  📦 Installing Oh My Zsh..."
        RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        echo "  ✅ Oh My Zsh installed"
    else
        echo "  ❌ Oh My Zsh is required. Aborting."
        exit 1
    fi
else
    echo "  ✅ Oh My Zsh"
fi

# ────────────────────────────────────────────────────────────────
# Homebrew packages
# ────────────────────────────────────────────────────────────────

if command -v brew >/dev/null 2>&1 && [ -f "$DOTFILES_BASE_DIR/Brewfile" ]; then
    print_section "📦  Homebrew Packages"

    already=()
    missing_formulas=()
    missing_casks=()

    re_formula='^brew[[:space:]]+"([^"]+)"'
    re_cask='^cask[[:space:]]+"([^"]+)"'

    while IFS= read -r line; do
        [[ "$line" =~ ^[[:space:]]*# ]] && continue
        [[ -z "${line// }" ]] && continue
        if [[ "$line" =~ $re_formula ]]; then
            pkg="${BASH_REMATCH[1]}"
            if brew list --formula "$pkg" >/dev/null 2>&1; then
                already+=("$pkg")
            else
                missing_formulas+=("$pkg")
            fi
        elif [[ "$line" =~ $re_cask ]]; then
            pkg="${BASH_REMATCH[1]}"
            if brew list --cask "$pkg" >/dev/null 2>&1; then
                already+=("$pkg")
            else
                missing_casks+=("$pkg")
            fi
        fi
    done < "$DOTFILES_BASE_DIR/Brewfile"

    if [ "${#missing_formulas[@]}" -eq 0 ] && [ "${#missing_casks[@]}" -eq 0 ]; then
        echo "  ✅ All packages up to date"
        [ "${#already[@]}" -gt 0 ] && printf "     %s\n" "$(join_by ", " "${already[@]}")"
    else
        [ "${#already[@]}" -gt 0 ] && printf "  ✅ Installed:  %s\n" "$(join_by ", " "${already[@]}")"
        all_missing=("${missing_formulas[@]}" "${missing_casks[@]}")
        printf "  📋 Missing:    %s\n" "$(join_by ", " "${all_missing[@]}")"
        echo ""
        for pkg in "${missing_formulas[@]}"; do
            read -p "  → Install $pkg? (Y/n): " confirm
            if [[ "$confirm" != "n" && "$confirm" != "N" ]]; then
                brew install "$pkg" >/dev/null 2>&1 \
                    && echo "    ✔ $pkg installed" \
                    || echo "    ❌ Failed to install $pkg"
            else
                echo "    ⏭️  Skipped $pkg"
            fi
        done
        for pkg in "${missing_casks[@]}"; do
            read -p "  → Install $pkg (app)? (Y/n): " confirm
            if [[ "$confirm" != "n" && "$confirm" != "N" ]]; then
                brew install --cask "$pkg" >/dev/null 2>&1 \
                    && echo "    ✔ $pkg installed" \
                    || echo "    ❌ Failed to install $pkg"
            else
                echo "    ⏭️  Skipped $pkg"
            fi
        done
    fi
fi

# ────────────────────────────────────────────────────────────────
# Dotfiles
# ────────────────────────────────────────────────────────────────

print_section "🔗  Dotfiles"

# [ZSH]
print_subsection "ZSH"
link_file "$DOTFILES_BASE_DIR/zsh/.zshrc"     "$HOME/.zshrc"
link_file "$DOTFILES_BASE_DIR/zsh/.zprofile"  "$HOME/.zprofile"
link_file "$DOTFILES_BASE_DIR/zsh/.zshenv"    "$HOME/.zshenv"
link_file "$DOTFILES_BASE_DIR/zsh/.hushlogin" "$HOME/.hushlogin"

# [GIT]
print_subsection "GIT"
link_file "$DOTFILES_BASE_DIR/git/.gitconfig"        "$HOME/.gitconfig"
link_file "$DOTFILES_BASE_DIR/git/.gitmessage"       "$HOME/.gitmessage"
link_file "$DOTFILES_BASE_DIR/git/.gitignore-global" "$HOME/.gitignore-global"
if [ ! -f "$HOME/.gitconfig.local" ]; then
    touch "$HOME/.gitconfig.local"
    echo "  ✔ ~/.gitconfig.local created"
fi
git config --global core.excludesfile ~/.gitignore-global
echo "  ✔ core.excludesfile configured"

# [VS CODE]
print_subsection "VS CODE"
VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
if [[ -d "$VSCODE_USER_DIR" ]]; then
    cp "$DOTFILES_BASE_DIR/vscode/settings.json" "$VSCODE_USER_DIR/settings.json"
    echo "  ✔ settings.json"
    cp "$DOTFILES_BASE_DIR/vscode/mcp.json"      "$VSCODE_USER_DIR/mcp.json"
    echo "  ✔ mcp.json"
    install_vscode_extensions "$DOTFILES_BASE_DIR/vscode/extensions.txt"
else
    echo "  ⚠️  VS Code config directory not found — skipping"
fi

# [FONTS]
print_subsection "FONTS"
FONT_DIR="$DOTFILES_BASE_DIR/font"
FONT_DEST="$HOME/Library/Fonts"
TMP_FONT_DIR=$(mktemp -d)

if [ -d "$FONT_DIR" ]; then
    font_total=0
    for zipfile in "$FONT_DIR"/*.zip; do
        [ -f "$zipfile" ] || continue
        name="$(basename "$zipfile" .zip)"
        unzip -qo "$zipfile" -d "$TMP_FONT_DIR/$name"
        count=$(find "$TMP_FONT_DIR/$name" -type f \( -name '*.ttf' -o -name '*.otf' \) | wc -l | tr -d ' ')
        if [ "$count" -gt 0 ]; then
            find "$TMP_FONT_DIR/$name" -type f \( -name '*.ttf' -o -name '*.otf' \) -exec cp {} "$FONT_DEST/" \;
            echo "  ✔ $name ($count files)"
            font_total=$(( font_total + count ))
        fi
    done
    for ext in ttf otf; do
        for f in "$FONT_DIR"/*.$ext; do
            [ -f "$f" ] || continue
            cp "$f" "$FONT_DEST/"
            echo "  ✔ $(basename "$f")"
            font_total=$(( font_total + 1 ))
        done
    done
    [ "$font_total" -eq 0 ] && echo "  ⚪ No font files found"
else
    echo "  ⚪ Font directory not found"
fi
rm -rf "$TMP_FONT_DIR"

# [ITERM2]
print_subsection "ITERM2"
ITERM_THEME="$DOTFILES_BASE_DIR/iterm2/themes/Solarized Dark Corrected.itermcolors"
if [ -f "$ITERM_THEME" ]; then
    echo "  ℹ  Theme available — double-click to import:"
    echo "     ~/.dotfiles/iterm2/themes/Solarized Dark Corrected.itermcolors"
fi

mkdir -p "$HOME/.cache/zsh"

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

