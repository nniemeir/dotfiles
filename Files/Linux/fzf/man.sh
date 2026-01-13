#!/usr/bin/env bash

source "$HOME/.dotfiles/Files/Linux/preferences.conf" || {
    echo "Error: No configuration file found."
    exit 1
}

manual=$(man -k . | sort -u | awk '{print $1, $2}' | fzf $FZF_DEFAULT_OPTS --prompt="Manuals: " | awk '{print $1}')

if [[ -n "$manual" ]]; then
    man $manual
fi

exit 0


