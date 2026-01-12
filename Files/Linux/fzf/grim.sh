#!/bin/bash

source "$HOME/.dotfiles/Files/Linux/preferences.conf" || {
    echo "Error: No configuration file found."
    exit 1
}

mkdir -p "$SCREENSHOT_DIR"

file=ps_$(date +"%Y%m%d%H%M%S").png

choice=$(printf "Selected Area\nWhole Screen" | fzf --prompt="Screenshot > ")

case "$choice" in
	"Selected Area")
	grim -g "$(slurp)" $SCREENSHOT_DIR/$file
	;;
	"Whole Screen")
	grim $SCREENSHOT_DIR/$file
	;;
esac

if [ -f "$SCREENSHOT_DIR/$file" ]; then
	notify-send "Screenshot Saved" -i $SCREENSHOT_DIR/$file
fi

if [ ! "$(ls $SCREENSHOT_DIR)" ]; then
	rm -rf "$SCREENSHOT_DIR"
fi
