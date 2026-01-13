#!/bin/bash

source "$HOME/.dotfiles/Files/Linux/preferences.conf" || {
    echo "Error: No configuration file found."
    exit 1
}

filename=$(find ~/.dotfiles/Files/Linux/ -type f -print | fzf $FZF_DEFAULT_OPTS --prompt="Edit a config file:" | awk '{print $1}')
if [ -n "$filename" ]; then
    nvim "$filename"
fi
