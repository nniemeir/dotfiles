#!/usr/bin/env bash

op=$( echo -e " Lock\n Suspend\n Reboot\n Power Off" | rofi -i -dmenu -p "" | awk '{print tolower($2)}' )

case $op in 
        poweroff)
                ;&
        reboot)
                ;&
        suspend)
                systemctl $op
                ;;
        lock)
	 swaylock -i ~/MEGA/Images/Wallpapers/dark_helvete.png --color=282a36  --indicator-radius=100 --indicator-thickness=10 --inside-color=282a36 --inside-clear-color=282a36 --inside-ver-color=282a36 --inside-wrong-color=282a36 --key-hl-color=bd93f9aa --bs-hl-color=ff5555aa --ring-color=44475a90 --ring-ver-color=bd93f9 --ring-clear-color=ff79c611 --line-color=282a36 --line-uses-ring --ring-wrong-color=ff5555 	
                ;;
esac
