#!/bin/sh
# This is a modified version of Bread On Penguins audio_output_switch script adapted to work with rofi
# Create a list of sinks with pretty names
options=$(pactl -f json list sinks | jq -r '.[] | .description')

# Let the user select a description
selection=$(echo "$options" | rofi -dmenu -p "Output:")

# Extract the corresponding sink name
sink_name=$(pactl -f json list sinks | jq -r --arg sink_pretty_name "$selection" '.[] | select(.description == $sink_pretty_name) | .name')

# Set the selected sink as default
if [ -n "$sink_name" ]; then
    pactl set-default-sink "$sink_name" && notify-send "Audio switched to: $selection"
else
    notify-send "Audio switch failed"
fi
