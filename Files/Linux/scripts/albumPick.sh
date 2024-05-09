
#recordSifter
# Choose a random album from a to-be-listened CSV and play it with mpv.
clear
SOURCEFILE="$HOME/MEGA/Education/Notes/TBL.txt"
LOGFILE="$HOME/MEGA/Education/Notes/Music Log.txt"
genre=$(awk -F ";" '{print $3}' "$SOURCEFILE" | sort -u | fzf --delimiter , --with-nth -1 --height=80% --padding=5,40,0,40 --layout=reverse --cycle --prompt="Select Genre: ")
FILTERED=$(awk -F ";" -v genre="$genre" '$3==genre {print $0}' "$SOURCEFILE")
LINECOUNT=$(echo "$FILTERED" | wc -l)
chosenLine=$(shuf -i 2-$LINECOUNT -n 1)
artist=$(echo "$FILTERED" | awk -F ";" -v chosenLine="$chosenLine" 'NR==chosenLine{print $1}')
album=$(echo "$FILTERED" | awk -F ";" -v chosenLine="$chosenLine" 'NR==chosenLine{print $2}')
echo "Searching for $artist - $album"
mpv --no-audio-display --term-playing-msg='Title: ${media-title}' --ytdl-format=bestaudio "ytdl://ytsearch:$artist $album full album"

read -p "Add album to logbook? " -n 1 -r
echo   
if [[ $REPLY =~ ^[Yy]$ ]]
then
fullRow=$(awk -F ";" -v chosenLine="$chosenLine" 'NR==chosenLine' "$SOURCEFILE")
echo "$fullRow" >> "$LOGFILE"
sed -i "${chosenLine}d" "$SOURCEFILE"
fi
