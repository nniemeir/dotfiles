### Set PATH
PATH=$PATH:~/.local/bin
PATH=$PATH:~/.cargo/bin

### Set Prompt
PS1=$'[%{\e[0;35m%}%n%{\e[0m%}@%{\e[0;35m%}%M%{\e[0m%}] %B%~%b '

### ALIASES
FZF_SCRIPTS_PATH="~/.dotfiles/Files/Linux/fzf"

# Fzf Scripts
alias audio="$FZF_SCRIPTS_PATH/audio_output.sh" 
alias bluetooth="$FZF_SCRIPTS_PATH/bluetooth.sh"
alias bookmarks="$FZF_SCRIPTS_PATH/bookmarks.sh"
alias config="$FZF_SCRIPTS_PATH/config.sh"
alias control="$FZF_SCRIPTS_PATH/control.sh" 
alias films="$FZF_SCRIPTS_PATH/films.sh"
alias games="$FZF_SCRIPTS_PATH/games.sh"
alias killcli="$FZF_SCRIPTS_PATH/kill.sh"
alias launch="$FZF_SCRIPTS_PATH/launcher.sh"
alias mancli="$FZF_SCRIPTS_PATH/man.sh"
alias media="$FZF_SCRIPTS_PATH/media.sh"
alias music="$FZF_SCRIPTS_PATH/music.sh"
alias overview="$FZF_SCRIPTS_PATH/overview.sh"
alias television="$FZF_SCRIPTS_PATH/television.sh"
alias themes="$FZF_SCRIPTS_PATH/themes.sh"
alias wallpapers="$FZF_SCRIPTS_PATH/wallpapers.sh"

# Drives
alias game_mount="sudo cryptsetup open /dev/sda1 games && sudo mount /dev/mapper/games /mnt/games"
alias media_mount="sudo cryptsetup open /dev/sdb media && sudo mount /dev/mapper/media /mnt/media"

# Media
alias png="find . -name '*.jpg' -exec mogrify -format png {} \;"
alias jpg="find . -name '*.png' -exec mogrify -format jpg {} \;"

# System
alias upgrade="sudo dnf upgrade -y && flatpak update -y"

# Quote Generator
wisesay Jesus
