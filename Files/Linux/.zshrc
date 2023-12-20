# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

alias game_mount="sudo cryptsetup open /dev/sda gaming && sudo mount /dev/mapper/gaming /mnt/gaming"
alias media_mount="sudo cryptsetup open /dev/sdb media && sudo mount /dev/mapper/media /mnt/media"

alias study="ranger 'MEGA/Academic/Community College/Courses/7. Fall 2023/'"
study_dir="/home/natalie/MEGA/Academic/Community College/Courses/7. Fall 2023" 
alias algebra="ranger '/home/natalie/MEGA/Academic/Community College/Courses/7. Fall 2023/College Algebra'"
alias py="ranger '/home/natalie/MEGA/Academic/Community College/Courses/7. Fall 2023/Python'"
alias project="ranger '/home/natalie/MEGA/Academic/Community College/Courses/7. Fall 2023/Project Management'"
alias capstone="ranger '/home/natalie/MEGA/Academic/Community College/Courses/7. Fall 2023/Capstone'"
alias upgrade="sudo dnf upgrade -y && flatpak update -y"
#To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#source ~/.powerlevel10k/powerlevel10k.zsh-theme

# Startup Script
#free -m | awk 'NR==2{printf "RAM: %.0f / %.0f MB\n", $3, $2}'
#hostname -i | awk '{print "IP: " $1}'
#nmcli -t -f name,device connection show --active | grep wlo1 | cut -d\: -f1 | sed 's/^/Network: /'

source ~/.powerlevel10k/powerlevel10k.zsh-theme
PATH=$PATH:~/.local/bin

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
