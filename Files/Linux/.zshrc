# Include .local/bin in PATH
PATH=$PATH:~/.local/bin

# Powerlevel10K
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Drives
GAME_DRIVE="/dev/sda"
MEDIA_DRIVE="/dev/sdb"
alias game_mount="sudo cryptsetup open $GAME_DRIVE games && sudo mount /dev/mapper/games /mnt/games"
alias media_mount="sudo cryptsetup open $MEDIA_DRIVE media && sudo mount /dev/mapper/media /mnt/media"

# Media
alias books="cd ~/.dotfiles/Files/Linux/fzf/ && ./books.sh"
alias films="cd /mnt/media/Video/Video_Binder && ./binder.sh"
alias games="cd /mnt/games/Games/Game_Binder/ && ./binder.sh"
alias music="cd ~/.dotfiles/Files/Linux/fzf/ && ./music.sh"
alias notes="cd ~/.dotfiles/Files/Linux/fzf/ && ./notebooks.sh"
alias png="find . -name '*.jpg' -exec mogrify -format png {} \;"
alias wallpaper="cd ~/.dotfiles/Files/Linux/sway/scripts/ && ./wallpaper.sh"
# Navigation
alias cdnotes="cd $HOME/MEGA/Academic/Notes/"


# System
alias upgrade="sudo dnf upgrade -y && flatpak update -y"
