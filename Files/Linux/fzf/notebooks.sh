#!/bin/bash
finished="0"
while [ $finished == "0" ]; do
clear
notePath="$HOME/MEGA/Academic/Notes/"
noteFiles=$(ls "$notePath/"*.{md,tex} 2>/dev/null)
selection=$(echo "$noteFiles" | xargs -I {} basename "{}" | fzf --preview="cat $HOME/MEGA/Academic/Notes/{}" --preview-window=right:70%:wrap --reverse)
if [ -z "$selection" ]; then
	finished="1"
else
	nvim "$notePath/$selection"
fi
done
