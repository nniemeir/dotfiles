#!/bin/bash
#Author: Natalie Niemeir
screenshotDir=(~/Pictures/Screenshots)

options(){
	printf "1. Selected Area\n"
	printf "2. Whole Screen"
}

choice=$(options | rofi -dmenu -p "Screenshot Area: "| cut -d. -f1)
case $choice in 
	1)
		mkdir $screenshotDir
		file=ps_$(date +"%Y%m%d%H%M%S").png
		grim -g "$(slurp)" $screenshotDir/$file
		notify-send "Screenshot Saved" -i $screenshotDir/$file
	;;

	2)
		mkdir $screenshotDir
		file=ps_$(date +"%Y%m%d%H%M%S").png
		grim $screenshotDir/$file
		notify-send "Screenshot Saved" -i $screenshotDir/$file
	;;
esac 
