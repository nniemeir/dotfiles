#! /bin/bash
# List gathered from Papirus-Folders
accentList="adwaita\nblack\nblue\nbluegrey\nbreeze\nbrown\ncarmine\ncyan\ndarkcyan\ndeeporange\ngreen\ngrey\nindigo\nmagenta\nnordic\norange\npalebrown\npaleorange\npink\nred\nteal\nviolet\nwhite\nyaru\nyellow"
theme=$(ls ~/.local/share/themes/ | fzf)
if [ -n "$theme" ]; then
accent=$(echo -e "$accentList" | fzf)
else 
	exit 0
fi
if [ -n "$accent" ]; then
gsettings set org.gnome.desktop.wm.preferences theme "$theme"
gsettings set org.gnome.desktop.interface gtk-theme "$theme"
papirus-folders -t Papirus-Dark -C "$accent"
rm -rf ~/.dotfiles/Files/Linux/style.css
cp "$HOME/.dotfiles/Files/Linux/waybar/themes/$theme.css" "$HOME/.dotfiles/Files/Linux/waybar/style.css"
rm -rf $HOME/.dotfiles/Files/Linux/rofi/config.rasi
cp "$HOME/.dotfiles/Files/Linux/rofi/themes/$theme.rasi" "$HOME/.dotfiles/Files/Linux/rofi/config.rasi"

sed -i "s|include /home/natalie/.dotfiles/Files/Linux/sway/themes/.*|include /home/natalie/.dotfiles/Files/Linux/sway/themes/$theme|g" "/home/natalie/.dotfiles/Files/Linux/sway/config"
case $theme in
  Catppuccin-Mocha-Standard-Lavender-Dark)
    kitten themes "Catppuccin-Mocha"
    ;;
  Dracula)
    kitten themes "Dracula"
    ;;
  Gruvbox-Dark-BL)
    kitten themes "Gruvbox Dark"
    ;;
  Nordic-darker)
    kitten themes "Nord"
    ;;
  *)
    STATEMENTS
    ;;
esac

else
	exit 0
fi
