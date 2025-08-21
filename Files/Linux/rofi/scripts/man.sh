#!/usr/bin/env bash
manual="$(man -k . | rofi -dmenu -p "Manuals: " | awk '{print $1}')"

if [[ -n "$manual" ]]; then
   alacritty -e sh -c "man $manual"
fi

exit 0


