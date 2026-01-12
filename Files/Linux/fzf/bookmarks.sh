#!/bin/sh

source "$HOME/.dotfiles/Files/Linux/preferences.conf" || {
    echo "Error: No configuration file found."
    exit 1
}

title=$(awk -F ";" 'NR>1 {print $1}' $BOOKMARKS_FILE | sort -u | fzf --reverse)
if [[ -z "$title" ]]; then exit 0; fi
link=$(awk -F ";" -v t="$title" '$1 == t { print $2 }' $BOOKMARKS_FILE)
xdg-open "$link"
