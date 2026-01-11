    #!/bin/bash
    filename=$(find ~/.dotfiles/Files/Linux/ -type f -print | fzf --prompt="Edit a config file:" | awk '{print $1}')
    if [ -n "$filename" ]; then
        nvim "$filename"
    fi
