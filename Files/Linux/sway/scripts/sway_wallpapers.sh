#!/bin/bash
wallDir="$HOME/MEGA/Images/Wallpapers"
selection=$(ls $wallDir | fzf --preview="kitty icat --clear --transfer-mode=stream --stdin=no --place=50x50@30x30 /home/noodle/MEGA/Images/Wallpapers/{}")
if [ -n "$selection" ]; then
swaymsg output "*" bg "$wallDir/$selection" fill &
sed -i "s|bg .* fill|bg $wallDir/$selection fill|" "$HOME/.dotfiles/Files/Linux/sway/config"
else
	exit 0
fi
