#!/bin/bash
# Author: Jacob Niemeir <nniemeir@protonmail.com>
# This script will automatically create symlinks for the included configuration files

dotsPath="$HOME/.dotfiles/Files/Linux"
toConfigDir=('dunst' 'fzf' 'hypr' 'kitty' 'mpv' 'nvim' 'ranger' 'rofi' 'sway' 'waybar' 'zathura')
toHomeDir=('.zshrc')

for item in "${toConfigDir[@]}"; do
	ln -s "$dotsPath/$item" "$HOME/.config"
done

for item in "${toHomeDir[@]}"; do
	ln -s "$dotsPath/$item" $HOME
done


