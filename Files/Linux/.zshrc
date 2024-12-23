# Include .local/bin in PATH
PATH=$PATH:~/.local/bin

PS1=$'[%{\e[0;35m%}%n%{\e[0m%}@%{\e[0;35m%}%M%{\e[0m%}] %B%~%b '
DOTFILES="$HOME/.dotfiles/"
# ALIASES
alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

## Education
alias notes="cd ~/.dotfiles/Files/Linux/fzf/ && ./notebooks.sh"

## Customization
alias themes="cd $DOTFILES/Files/Linux/sway/scripts/ && ./sway_themes.sh"
alias wallpapers="cd $DOTFILES/Files/Linux/sway/scripts/ && ./sway_wallpapers.sh"

## Drives
GAME_DRIVE="/dev/sda1"
MEDIA_DRIVE="/dev/sdb"
alias game_mount="sudo cryptsetup open $GAME_DRIVE games && sudo mount /dev/mapper/games /mnt/games"
alias media_mount="sudo cryptsetup open $MEDIA_DRIVE media && sudo mount /dev/mapper/media /mnt/media"

## Media
alias png="find . -name '*.jpg' -exec mogrify -format png {} \;"

alias leisure="cd $HOME/MEGA/Education/Independent\ Studies/leisureLib && ./leisureLib.sh"

## System
alias upgrade="sudo dnf upgrade -y && flatpak update -y"

