#!/bin/bash
clear
note_path="$HOME/MEGA/Coursework & Notes/"
finished="0"
while [ $finished == "0" ]; do
	note_files=$(ls "$note_path/"*.{csv,md,tex,txt} 2>/dev/null)
	selection=$(echo "$note_files" | xargs -I {} basename "{}" | fzf --preview="cat -n '$note_path{}'" --preview-window=right:70%:wrap --reverse)
	if [ -z "$selection" ]; then
		finished="1"
	else
		nvim "$note_path/$selection"
	fi
done
