#!/bin/bash
#Author: Natalie Niemeir

options(){
	printf "1. Selected Area\n"
	printf "2. Whole Screen"
}

choice=$(options | rofi -dmenu -p "Screenshot Menu "| cut -d. -f1)
case $choice in 
	1)
		grim -g "$(slurp)" ~/ps_$(date +"%Y%m%d%H%M%S").png
	;;

	2)
		grim ~/ps_$(date +"%Y%m%d%H%M%S").png
	;;
esac 