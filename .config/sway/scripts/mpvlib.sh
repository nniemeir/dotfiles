#!/bin/bash
#Author: Natalie Niemeir
path=/mnt/media/Video/Movies
chosen=$(find $path -type f -regex '.*\.\(mkv\|mp4\)$' | sed 's!.*/!!' | rofi -dmenu -p "" -theme mpvlib.rasi)
mpv --fs $path/"$chosen"
