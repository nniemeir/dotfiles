#!/bin/bash
wallpaper_dir="$HOME/MEGA/Media/Images/Wallpapers"

if [[ $TERM == *kitty* ]]; then
  prompt="fzf --cycle --preview='kitty icat --clear --transfer-mode=stream --stdin=no --place=50x50@30x30 $wallpaper_dir/{}'"
else
  prompt="fzf --cycle"
fi

selection=$(ls $wallpaper_dir | $prompt)

if [ -n "$selection" ]; then
	swaymsg output "*" bg "$wallpaper_dir/$selection" fill &
	sed -i "s|bg .* fill|bg $wallpaper_dir/$selection fill|" "$HOME/.dotfiles/Files/Linux/sway/styling.conf"
else
	exit 0
fi
