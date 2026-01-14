#!/bin/sh

source "$HOME/.dotfiles/Files/Linux/preferences.conf" || {
    echo "Error: No configuration file found."
    exit 1
}

finished=false
while [ "$finished" = "false" ]; do
    selection=$(find "$BOOKS_PATH" -type f \( -name "*.epub" -o -name "*.pdf" \) | sort -u | fzf $FZF_DEFAULT_OPTS)
    if [ -z "$selection" ]; then
        finished=true
    else
        zathura "$BOOKS_PATH/$selection".* 2>/dev/null &
    fi
done