#!/bin/bash
#Author: Natalie Niemeir

echo "" | rofi -dmenu -p "DuckDuckGo: "| xargs -I{} xdg-open https://duckduckgo.com/?q={}&t=h

