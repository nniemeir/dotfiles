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
depends mpv

finished=false
while [ "$finished" == "false" ]; do
    film_files=$(find "$MOVIES_PATH" -type f \( -name "*.mkv" -o -name "*.mp4" \) | sort)
    selection=$(echo "$film_files" | fzf $FZF_DEFAULT_OPTS)
    if [ -z "$selection" ]; then
        finished=true
    else
        mpv "$selection" --fullscreen >/dev/null 2>&1 &
    fi
done