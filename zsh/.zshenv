# Prefer US English and use UTF-8
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Make nano the default editor
export EDITOR="nano"

# History (allow 4096 entries; default is 500)
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=50000
export SAVEHIST=50000
export HISTORY_IGNORE="(ls|cd|cd -|pwd|exit|date|* --help)"

# Disable history file for less pager
export LESSHISTFILE=-

# Highlight section titles in manual pages (bold yellow)
export LESS_TERMCAP_md=$'\e[1;33m'
export LESS_TERMCAP_me=$'\e[0m'

# Don't clear the screen after quitting a manual page
export MANPAGER="less -X"

# Do not auto update brew
export HOMEBREW_NO_AUTO_UPDATE=1
