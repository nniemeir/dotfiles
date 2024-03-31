#Author: Nat Niemeir
#This script will automatically create symlinks for your dotfiles#
#!/bin/bash
dotsPath="$HOME/.dotfiles/Files/Linux"
toConfigDir=('awesome' 'cmus' 'dunst' 'kitty' 'mpv' 'nvim' 'ranger' 'rofi' 'sway' 'waybar' 'picom.conf' 'zathura')
toHomeDir=('.vimrc' '.zshrc')

for item in "${toConfigDir[@]}"; do
	ln -s "$dotsPath/$item" "$HOME/.config"
done

for item in "${toHomeDir[@]}"; do
	ln -s "$dotsPath/$item" $HOME
done


