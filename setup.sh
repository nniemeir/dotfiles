#Author: Natalie Niemeir
#This script will automatically create symlinks for your dotfiles#
#!/bin/bash

dotsPath="~/.dotfiles/Files/Linux"

#toConfigDir=('awesome/' 'cmus/' 'dunst/' 'kitty/' 'nvim/' '')
ln -s $dotsPath/awesome/ ~/.config/
ln -s $dotsPath/cmus/ ~/.config/
ln -s $dotsPath/dunst/ ~/.config/
ln -s $dotsPath/kitty/ ~/.config/
ln -s $dotsPath/nvim/ ~/.config/
ln -s $dotsPath/ranger/ ~/.config/
ln -s $dotsPath/rofi/ ~/.config/
ln -s $dotsPath/sway/ ~/.config/
ln -s $dotsPath/waybar/ ~/.config/
ln -s $dotsPath/picom.conf ~/.config/
ln -s $dotsPath/.vimrc ~/
ln -s $dotsPath/.zshrc ~/
#ln -s $dotsPath/GNOME/extensions/ ~/.local/share/gnome-shell/
ln -s $dotsPath/zathura ~/.config/
ln -s $dotsPath/mpv ~/.config/


