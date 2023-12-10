#!/bin/bash
chosen=$(awk -F'"' '$0=$2' stations.txt | rofi -dmenu -p "Select a Station " )
link=$(grep -oP "\"$chosen\"\K.*" stations.txt)
if [ "$link" != "" ]; then 
   mpv $link --no-video
else
   exit
fi
