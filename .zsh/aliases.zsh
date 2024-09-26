# Common
alias cp="cp -i"
alias df="df -h"
alias ll="\ls -al --color"
alias ls="\ls -a --color"
alias free="free -m"

# How to exit vim?
alias :q=exit
alias :qa=exit
alias :wq=exit
alias :wqa=exit

alias .="cd .."
alias ..="cd ../.."
alias ...="cd ../../.."
alias ....="cd ../../../.."

# Utils
alias xcp="xclip -sel clip"
alias cpwd="pwd | xclip -sel clip"
[[ "$TERM" == "xterm-kitty" ]] && alias ssh="kitty +kitten ssh"

# Applications
alias vim="nvim"
alias emulator="$ANDROID_SDK_HOME/emulator/emulator"
alias neofetch="neofetch --ascii ~/.neoart --ascii_colors 4 3 1 2 5 6"
alias tty-clock="tty-clock -sc -C 3"

# Shortcut
cdlg() {
    cd /media/LG/$1
}
