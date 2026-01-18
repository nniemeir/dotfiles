#!/bin/sh
# This script will create symlinks for the included configuration files and clone sway autotiling script into appropriate dir

git clone https://github.com/nwg-piotr/autotiling

mv autotiling/autotiling/main.py ~/.dotfiles/Files/Linux/sway/scripts/autotiling.py 

rm -rf autotiling

dotsPath="$HOME/.dotfiles/Files"
toConfigDir=('Linux/dunst' 'Linux/filmfs' 'Linux/kitty' 'Linux/mpv' 'Common/nvim' 'Linux/ranger' 'Linux/sway' 'Linux/zathura')
toHomeDir=('Linux/.zshrc')
toFzfWuzzy=('bookmarks.csv' 'drives.csv' 'games.csv' 'preferences.conf')

for item in "${toConfigDir[@]}"; do
	ln -s "$dotsPath/$item" "$HOME/.config"
done

for item in "${toHomeDir[@]}"; do
	ln -s "$dotsPath/$item" $HOME
done

for item in "${toFzfWuzzy[@]}"; do
	ln -s "$dotsPath/Linux/fzf-wuzzy/$item" "$HOME/.fzf-wuzzy/config"
done
