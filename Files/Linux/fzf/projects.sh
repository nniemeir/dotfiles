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
depends flatpak

selection=$(ls "$PROJECTS_PATH" | fzf $FZF_DEFAULT_OPTS)	

if [ -z "$selection" ]; then
    exit 0
else
    flatpak run com.visualstudio.code-oss "$PROJECTS_PATH/$selection"
fi
