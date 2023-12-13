#!/bin/bash
#Author: Natalie Niemeir

echo "" | rofi -dmenu -p "Search The Web: "| xargs -I{} xdg-open https://duckduckgo.com/?q={}&t=h

