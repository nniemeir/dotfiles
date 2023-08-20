#!/bin/bash
#Author: Natalie Niemeir

echo "" | rofi -dmenu | xargs -I{} xdg-open https://www.google.de/search?q={}

