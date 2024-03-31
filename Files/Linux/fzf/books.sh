clear

bookPath="$HOME/MEGA/Academic/Books"
bookFiles=$(ls "$bookPath/"*.{epub,pdf} 2>/dev/null)
selection=$(echo "$bookFiles" | xargs -I {} basename "{}" | sed 's/\.[^.]*$//' | fzf --height=80% --padding=5,40,0,40 --layout=reverse --cycle --prompt="Select Book: " --preview='
file_path=/home/nat/MEGA/Academic/Books/covers/{}
file_name="${file_path%.*}"
preview_file="${file_name}.png"
if [ -e "$preview_file" ]; then
  kitty icat --clear --transfer-mode=stream --stdin=no --place=40x40@20x20 "$preview_file"
else
  kitty icat --clear --transfer-mode=stream --stdin=no --place=40x40@20x20 "/home/natalie/MEGA/Academic/Books/covers/error.png"
fi
' --preview-window noborder,up,30)


clear
kitty icat --clear
if [ -z "$selection" ]; then
	break
else
	zathura "$bookPath/$selection".* 2>/dev/null
fi

