    #!/bin/bash
    PID=$(ps -u $USER -o pid,comm | rofi -dmenu -p "Kill Process:" | awk '{print $1}')
    if [ -n "$PID" ]; then
        kill -9 "$PID"
    fi
