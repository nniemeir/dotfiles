#!/bin/bash
screenshot_dir="$HOME/Pictures/Screenshots"

mkdir -p "$screenshot_dir"

file=ps_$(date +"%Y%m%d%H%M%S").png

choice=$(echo -e "1. Selected Area\n2. Whole Screen" | rofi -dmenu -p "Screenshot Area: " | cut -d. -f1)

if [[ "$choice" == 1 ]]; then
	grim -g "$(slurp)" $screenshot_dir/$file
elif [[ "$choice" == 2 ]]; then
	grim $screenshot_dir/$file
fi

if [ -f "$screenshot_dir/$file" ]; then
	notify-send "Screenshot Saved" -i $screenshot_dir/$file
fi

if [ ! "$(ls $screenshot_dir)" ]; then
	rm -rf "$screenshot_dir"
fi
