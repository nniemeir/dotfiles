#!/bin/sh

SINK="@DEFAULT_SINK@"

if [ $1 = "+" ]; then
	pactl set-sink-volume @DEFAULT_SINK@ $(pactl get-sink-volume @DEFAULT_SINK@ | awk '/Volume: front-left/ {print $5}' | sed 's/%//g' | awk '{if ($1 < 100) print $1+10; else print 100}')%
elif [ "$1" = "-" ]; then
	pactl set-sink-volume @DEFAULT_SINK@ -10%
elif [ "$1" = "x" ]; then
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    MUTE_STATUS=$(pactl get-sink-mute @DEFAULT_SINK@ | awk -F ': ' '{ print $2 }')
    if [ "$MUTE_STATUS" = "yes" ]; then
        TEXT="Volume: Muted"
    else
        TEXT="Volume: Unmuted"
    fi
    notify-send \
    --app-name sway \
    --expire-time 800 \
    --transient \
    "${TEXT}"
    return
fi

get_sink_volume() { # sink
    ret=$(pactl get-sink-volume "$1")
    # get first percent value
    ret=${ret%%%*}
    ret=${ret##* }
    echo "$ret"
    unset ret
}

VOLUME=$(get_sink_volume "$SINK")
TEXT="Volume: ${VOLUME}%"

notify-send \
    --app-name sway \
    --expire-time 800 \
    --hint string:x-canonical-private-synchronous:volume \
    --hint "int:value:$VOLUME" \
    --transient \
    "${TEXT}"
