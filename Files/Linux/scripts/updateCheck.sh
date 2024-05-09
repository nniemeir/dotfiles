lastUpdate=$(dnf history --reverse | grep "upgrade -y" | tail -1 | awk '{ print $6 }') 
lastUpdateEpoch=$(date --date="$lastUpdate 00:00:00" +"%s")
currentTime=$(date +%s)
timeDiff=$(echo "$(($currentTime-$lastUpdateEpoch))")
daysSince=$(printf "%f\n" $((timeDiff/86400)))
if [ $daysSince != 0 ]; then
notify-send "Last System Update: ${daysSince%.*} days ago"
else
notify-send "Last System Update: Today"
fi
