#!/bin/bash
finished="0"
while [ $finished == "0" ]; do
clear
musicPath="$HOME/Drives/Media/Audio/"
musicFiles=$(ls -d "$musicPath"*/*/ | sed "s,$musicPath,,g")
musicSelection=$(echo "$musicFiles" | fzf --height=80% --padding=5,40,0,40 --layout=reverse --cycle --prompt="Select Album: " --preview='
file_path=/home/nat/Drives/Media/Audio/{}
preview_file="$file_path"cover.png
if [ -e "$preview_file" ]; then
  kitty icat --clear --transfer-mode=stream --stdin=no --place=40x40@20x20 "$preview_file"
else
echo $preview_file
  kitty icat --clear --transfer-mode=stream --stdin=no --place=40x40@20x20 "/home/natalie/MEGA/Academic/Books/covers/error.png"
fi
' --preview-window noborder,up,30)


clear
kitty icat --clear
if [ -z "$musicSelection" ]; then
	break
else
	mpv "$musicPath/$musicSelection" --no-video
fi
done
