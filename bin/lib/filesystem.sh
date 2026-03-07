# Create symlink (with backup of existing non-symlink destination)
link_file() {
    local src="$1"
    local dest="$2"
    local display="${dest/#$HOME/~}"

    if [ ! -e "$src" ]; then
        echo "  ❌ Source not found: $src"
        return 1
    fi

    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        echo "  ⚠️  Backing up $display"
        mv "$dest" "$dest.backup.$(date +%s)"
    fi

    ln -sf "$src" "$dest"
    echo "  ✔ $display"
}
