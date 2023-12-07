#!/bin/bash
#Author: Natalie Niemeir

echo "" | rofi -dmenu -p "Google: "| xargs -I{} xdg-open https://duckduckgo.com/?t=h_&q={}&ia=web

