#!/bin/bash
screenshot_dir="$HOME/Pictures/Screenshots"

mkdir -p "$screenshot_dir"

file=ps_$(date +"%Y%m%d%H%M%S").png

choice=$(printf "Selected Area\nWhole Screen" | fzf --prompt="Screenshot > ")

case "$choice" in
	"Selected Area")
	grim -g "$(slurp)" $screenshot_dir/$file
	;;
	"Whole Screen")
	grim $screenshot_dir/$file
	;;
esac

if [ -f "$screenshot_dir/$file" ]; then
	notify-send "Screenshot Saved" -i $screenshot_dir/$file
fi

if [ ! "$(ls $screenshot_dir)" ]; then
	rm -rf "$screenshot_dir"
fi
