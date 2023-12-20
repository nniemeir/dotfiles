#!/bin/bash
#Author: Natalie Niemeir
filmPath=/mnt/media
film=$(find "$filmPath" -type f -regex '.*\.\(mkv\|mp4\)$' | sed 's!.*/!!; s#[.][^.]*$##' | sort | rofi -dmenu -p "Films: " )
if [ -n "$film" ]; then
	filename=$(find $filmPath -maxdepth 1 -name "$film*" -print)   
	mpv --fs "$filename"
else 
	exit
fi
