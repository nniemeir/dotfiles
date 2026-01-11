#! /bin/bash
# List gathered from Papirus-Folders
accents="adwaita\nblack\nblue\nbluegrey\nbreeze\nbrown\ncarmine\ncyan\ndarkcyan\ndeeporange\ngreen\ngrey\nindigo\nmagenta\nnordic\norange\npalebrown\npaleorange\npink\nred\nteal\nviolet\nwhite\nyaru\nyellow"
theme=$(ls $HOME/.local/share/themes/ | fzf)

if [ -n "$theme" ]; then
	accent=$(echo -e "$accents" | fzf)
else
	exit 0
fi

if [ -n "$accent" ]; then
	gsettings set org.gnome.desktop.wm.preferences theme "$theme"
	gsettings set org.gnome.desktop.interface gtk-theme "$theme"
	gsettings set org.gnome.desktop.interface icon-theme "Papirus"
	sudo flatpak override --filesystem=$HOME/.local/share/themes/
	sudo flatpak override --env=GTK_THEME="$theme"
	papirus-folders -t Papirus -C "$accent"
else
	exit 0
fi
