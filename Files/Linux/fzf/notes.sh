#!/bin/bash

source "$HOME/.dotfiles/Files/Linux/preferences.conf" || {
    echo "Error: No configuration file found."
    exit 1
}

cd "$NOTE_PATH" || exit 1
finished="0"
while [ $finished == "0" ]; do
	note_files=$(find "$NOTE_PATH" -type f \( -iname "*.csv" -o -iname "*.md" -o -iname "*.tex" -o -iname "*.txt" \))
    	selection=$(echo "$note_files" | sed "s|$NOTE_PATH||" | fzf --preview="cat -n {}" --preview-window=right:70%:wrap --reverse)	
	if [ -z "$selection" ]; then
		finished="1"
	else
		nvim "$NOTE_PATH/$selection"
	fi
done
