#!/bin/bash
# This script will create symlinks for the included configuration files and clone sway autotiling script into appropriate dir

git clone https://github.com/nwg-piotr/autotiling

mv autotiling/autotiling/main.py ~/.dotfiles/Files/Linux/sway/scripts/autotiling.py 

dotsPath="$HOME/.dotfiles/Files/Linux"
toConfigDir=('alacritty' 'dunst' 'filmfs' 'fzf' 'gzdoom' 'hypr' 'kitty' 'mpd' 'mpv' 'nvim' 'ranger' 'rmpc' 'rofi' 'sway' 'waybar' 'zathura')
toHomeDir=('.zshrc')

for item in "${toConfigDir[@]}"; do
	ln -s "$dotsPath/$item" "$HOME/.config"
done

for item in "${toHomeDir[@]}"; do
	ln -s "$dotsPath/$item" $HOME
done


