#!/bin/bash
path=~/MEGA/Academic/Scripts
chosen=$(find $path -type f -name "*.sh" | sed 's!.*/!!' | rofi -dmenu -p "Courses: " )
if [ "$chosen" != "" ]; then
	cd $path
	./"$chosen"
else 
	exit
fi
