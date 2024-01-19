# Powerlevel10K Prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Include .local/bin in PATH
PATH=$PATH:~/.local/bin

# Aliases
alias game_mount="sudo cryptsetup open /dev/sda games && sudo mount /dev/mapper/games /mnt/games"
alias media_mount="sudo cryptsetup open /dev/sdb media && sudo mount /dev/mapper/media /mnt/media"
alias algebra="cd ~/MEGA/Academic/Scripts/ && ./College_Algebra.sh"
alias upgrade="sudo dnf upgrade -y && flatpak update -y"
alias films="cd /mnt/media/Video/Video_Binder && ./binder.sh"
alias games="cd /mnt/games/Games/Game_Binder/ && ./binder.sh"
