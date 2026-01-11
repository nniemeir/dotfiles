    #!/bin/bash
    PID=$(ps -u $USER -o pid,comm | awk 'NR>1' | fzf --prompt="Kill Process:" | awk '{print $1}')
    if [ -n "$PID" ]; then
        kill -9 "$PID"
    fi
