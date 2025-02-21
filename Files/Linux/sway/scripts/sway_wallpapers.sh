#!/bin/bash
wallpaper_dir="$HOME/MEGA/Images/Wallpapers"
selection=$(ls $wallpaper_dir | fzf --preview="kitty icat --clear --transfer-mode=stream --stdin=no --place=50x50@30x30 $HOME/MEGA/Images/Wallpapers/{}")

if [ -n "$selection" ]; then
	swaymsg output "*" bg "$wallpaper_dir/$selection" fill &
	sed -i "s|bg .* fill|bg $wallpaper_dir/$selection fill|" "$HOME/.dotfiles/Files/Linux/sway/config"
else
	exit 0
fi
