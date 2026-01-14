#!/bin/bash

source "$HOME/.dotfiles/Files/Linux/preferences.conf" || {
    echo "Error: No configuration file found."
    exit 1
}

source "$HOME/.dotfiles/Files/Linux/common.sh" || {
    echo "Error: common.sh missing from ~/.dotfiles/Files/Linux"
    exit 1
}

depends fzf

PID=$(ps -u $USER -o pid,comm | awk 'NR>1' | fzf $FZF_DEFAULT_OPTS --prompt="Kill Process:" | awk '{print $1}')
if [ -n "$PID" ]; then
    kill -9 "$PID"
fi
