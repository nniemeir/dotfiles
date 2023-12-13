#!/bin/bash
#Author: Natalie Niemeir
path=/run/media/natalie/Media/Video/Movies
chosen=$(find $path -type f -regex '.*\.\(mkv\|mp4\)$' | sed 's!.*/!!' | rofi -dmenu -p "Films: " )
if [ "$chosen" != "" ]; then
	mpv --fs $path/"$chosen"
else 
	exit
fi
