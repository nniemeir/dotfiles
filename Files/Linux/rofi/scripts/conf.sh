    #!/bin/bash
    filename=$(find ~/.dotfiles/Files/Linux/ -type f -print | rofi -dmenu -p "Edit a config file:" | awk '{print $1}')
    if [ -n "$filename" ]; then
        alacritty -e sh -c "nvim \"$filename\""
    fi
