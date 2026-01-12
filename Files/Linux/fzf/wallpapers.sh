#!/bin/bash

source "$HOME/.dotfiles/Files/Linux/preferences.conf" || {
    echo "Error: No configuration file found."
    exit 1
}

if [[ $TERM == *kitty* ]]; then
	fzf_cmd=(fzf --cycle --preview "kitty icat --clear --transfer-mode=stream --stdin=no --place=100x100@30x30 $WALLPAPER_DIR/{}")

else
	fzf_cmd=(fzf --cycle)
fi

selection=$(ls $WALLPAPER_DIR | "${fzf_cmd[@]}")

if [ -n "$selection" ]; then
	swaymsg output "*" bg "$WALLPAPER_DIR/$selection" fill &
	sed -i "s|bg .* fill|bg $WALLPAPER_DIR/$selection fill|" "$HOME/.dotfiles/Files/Linux/sway/styling.conf"
else
	exit 0
fi
