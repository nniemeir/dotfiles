# Include .local/bin in PATH
PATH=$PATH:~/.local/bin

PS1=$'[%{\e[0;35m%}%n%{\e[0m%}@%{\e[0;35m%}%M%{\e[0m%}] %B%~%b '
DOTFILES="$HOME/.dotfiles/"
# ALIASES

## Education
alias cdnotes="cd $HOME/MEGA/Education/Notes/"
alias notes="cd ~/.dotfiles/Files/Linux/fzf/ && ./notebooks.sh"
alias alrender="pdflatex -output-directory MAT121_output College\ Algebra.tex && clear"

## Customization
alias wallpapers="cd $DOTFILES/Files/Linux/scripts/ && ./wallpapers.sh"
alias themes="cd $DOTFILES/Files/Linux/scripts/ && ./themes.sh"

## Drives
GAME_DRIVE="/dev/sda"
MEDIA_DRIVE="/dev/sdb"
alias game_mount="sudo cryptsetup open $GAME_DRIVE games && sudo mount /dev/mapper/games /mnt/games"
alias media_mount="sudo cryptsetup open $MEDIA_DRIVE media && sudo mount /dev/mapper/media /mnt/media"

## Media
alias books="cd $DOTFILES/Files/Linux/fzf/ && ./books.sh"
alias films="cd /mnt/media/Video_Binder && ./binder.sh"
alias games="cd /mnt/games/Games/Game_Binder/ && ./binder.sh"
alias music="cd $DOTFILES/Files/Linux/scripts/ && ./albumPick.sh"
alias png="find . -name '*.jpg' -exec mogrify -format png {} \;"

## System
alias upgrade="sudo dnf upgrade -y && flatpak update -y"

ytmusic () {
    mpv --no-audio-display --ytdl-format=bestaudio "ytdl://ytsearch:$*"
}
