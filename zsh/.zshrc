# Path to your Oh My Zsh installation.
ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"
AGNOSTER_DIR_FG=black

# Hide username in prompt
DEFAULT_USER=`whoami`

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM="$HOME/.dotfiles/oh-my-zsh-custom"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git composer macos)

ZSH_COMPDUMP="$HOME/.cache/zsh/zcompdump"

source $ZSH/oh-my-zsh.sh

# --------------------------------------------------------------------------------
# USER CONFIGURATION
# --------------------------------------------------------------------------------

# Load the custom dotfiles, and then some:
for file in ~/.dotfiles/zsh/.{aliases,banners,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done

for file in ~/.dotfiles-custom/shell/.{aliases,banners,functions,zshrc}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# preserve MANPATH
export MANPATH="/usr/local/man:$MANPATH"

# python
if [ -d "/Library/Frameworks/Python.framework/Versions" ]; then
    PYTHON_LATEST=$(ls -1 /Library/Frameworks/Python.framework/Versions/ 2>/dev/null | grep -E '^[0-9]' | sort -V | tail -1)
    [ -n "$PYTHON_LATEST" ] && export PATH="/Library/Frameworks/Python.framework/Versions/$PYTHON_LATEST/bin:${PATH}"
fi

# herd
export PATH="$HOME/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="$HOME/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

# antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# fnm - Node.js version manager
if command -v fnm &> /dev/null; then
    eval "$(fnm env --use-on-cd)"
fi

dev_banner
