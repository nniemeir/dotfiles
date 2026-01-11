### Set PATH
PATH=$PATH:~/.local/bin
PATH=$PATH:~/.cargo/bin

### Set Prompt
PS1=$'[%{\e[0;35m%}%n%{\e[0m%}@%{\e[0;35m%}%M%{\e[0m%}] %B%~%b '

### ALIASES
DOTFILES="~/.dotfiles"

# Education
alias notes="$DOTFILES/Files/Linux/fzf/notes.sh"

# Misc
alias rand="$DOTFILES/Files/Linux/sway/scripts/rand.sh"

# Customization
alias themes="$DOTFILES/Files/Linux/sway/scripts/sway_themes.sh"
alias wallpapers="$DOTFILES/Files/Linux/sway/scripts/sway_wallpapers.sh"

# Drives
alias game_mount="sudo cryptsetup open /dev/sda1 games && sudo mount /dev/mapper/games /mnt/games"
alias media_mount="sudo cryptsetup open /dev/sdb media && sudo mount /dev/mapper/media /mnt/media"

# Media
alias png="find . -name '*.jpg' -exec mogrify -format png {} \;"
alias jpg="find . -name '*.png' -exec mogrify -format jpg {} \;"

# System
alias upgrade="sudo dnf upgrade -y && flatpak update -y"

alias bookmarks="~/.dotfiles/Files/Linux/fzf/bookmarks.sh ~/.dotfiles/Files/Linux/bookmarks.csv"

wisesay Jesus
