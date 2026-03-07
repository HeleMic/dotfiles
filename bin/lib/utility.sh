# Check command
check_command() {
    if command -v "$1" >/dev/null 2>&1; then
        echo "✅ $1 installed"
    else
        echo "❌ $1 NOT installed"
        suggest_install "$1"
    fi
}

# Suggest installation link
suggest_install() {
    case "$1" in
        git)
            echo "   → https://git-scm.com/downloads"
            ;;
        zsh)
            echo "   → https://www.zsh.org/"
            ;;
        figlet)
            echo "   → brew install figlet"
            ;;
        lolcat)
            echo "   → brew install lolcat"
            ;;
        brew)
            echo "   → https://brew.sh/"
            ;;
        eza)
            echo "   → https://github.com/eza-community/eza (optional)"
            ;;
        docker)
            echo "   → https://www.docker.com/products/docker-desktop/"
            ;;
        node)
            echo "   → https://nodejs.org/"
            ;;
        python3)
            echo "   → https://www.python.org/downloads/"
            ;;
        code)
            echo "   → https://code.visualstudio.com/"
            ;;
    esac
}

# Print a top-level section header
print_section() {
    local label="$1"
    echo ""
    if command -v lolcat >/dev/null 2>&1; then
        echo "  ─── $label" | lolcat
    else
        echo "  ─── $label"
    fi
    echo ""
}

# Print a subsection label
print_subsection() {
    echo ""
    echo "  [$1]"
}

# Join array elements with a separator
join_by() {
    local sep="$1"
    shift
    local result=""
    local first=true
    for item in "$@"; do
        if $first; then
            result="$item"
            first=false
        else
            result="${result}${sep}${item}"
        fi
    done
    echo "$result"
}

# VS Code extensions installation
install_vscode_extensions() {
    local extensions_file="$1"

    if ! command -v code >/dev/null 2>&1; then
        echo "  ⚠️  'code' command not found — skipping extensions"
        return
    fi

    if [ ! -f "$extensions_file" ]; then
        echo "  ❌ Extension list not found"
        return 1
    fi

    local installed_exts
    installed_exts=$(code --list-extensions 2>/dev/null)
    local count_ok=0
    local count_new=0
    local count_err=0

    while read -r extension || [ -n "$extension" ]; do
        [ -z "$extension" ] && continue
        if echo "$installed_exts" | grep -qi "^${extension}$"; then
            count_ok=$(( count_ok + 1 ))
        else
            if code --install-extension "$extension" --force >/dev/null 2>&1; then
                count_new=$(( count_new + 1 ))
            else
                count_err=$(( count_err + 1 ))
            fi
        fi
    done < "$extensions_file"

    if [ "$count_new" -eq 0 ] && [ "$count_err" -eq 0 ]; then
        echo "  ✔ $count_ok extensions up to date"
    else
        echo "  ✔ $count_ok already installed, $count_new newly installed"
        [ "$count_err" -gt 0 ] && echo "  ⚠️  $count_err extensions failed to install"
    fi
}
