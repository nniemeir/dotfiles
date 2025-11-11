#!/bin/bash
clear
note_path="$HOME/MEGA/Notes/"
finished="0"
while [ $finished == "0" ]; do
	note_files=$(find "$note_path" -type f \( -iname "*.csv" -o -iname "*.md" -o -iname "*.tex" -o -iname "*.txt" \))
    	selection=$(echo "$note_files" | sed "s|$note_path||" | fzf --preview="cat -n '$note_path{}'" --preview-window=right:70%:wrap --reverse)	
	if [ -z "$selection" ]; then
		finished="1"
	else
		nvim "$note_path/$selection"
	fi
done
