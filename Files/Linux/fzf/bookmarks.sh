#!/bin/sh

source "$HOME/.dotfiles/Files/Linux/preferences.conf" || {
    echo "Error: No configuration file found."
    exit 1
}

source "$HOME/.dotfiles/Files/Linux/common.sh" || {
    echo "Error: common.sh missing from ~/.dotfiles/Files/Linux"
    exit 1
}

depends fzf

title=$(awk -F ";" 'NR>1 {print $1}' $BOOKMARKS_FILE | sort -u | fzf $FZF_DEFAULT_OPTS)
if [[ -z "$title" ]]; then exit 0; fi
link=$(awk -F ";" -v t="$title" '$1 == t { print $2 }' $BOOKMARKS_FILE)
xdg-open "$link"
