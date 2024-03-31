#!/bin/bash
clear
echo "Select a Station: "
stations=("$HOME/.dotfiles/Files/Linux/sway/scripts/radio/stations.txt")
declare -i count=1
while IFS= read -r line; do
   printf "%d: %s\n" "$count" "$(echo "$line" | sed -n "${chosen} s/;.*//p")"
   let "count++"
done <"$stations"
read -r -s chosen
stationName=$(sed -n "${chosen} s/;.*//p" $stations)
link=$(sed -n "${chosen} s/^[^;]*;//p" $stations)
if [ "$link" != "" ]; then
   printf "\nNow playing: $stationName\nPause Playback: P\nAbort Playback: Q\n"
   mpv $link --no-video --really-quiet
else
   exit
fi
