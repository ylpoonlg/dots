# Shortcuts
abbr --add ":q" "exit" # How to exit vim?
abbr --add "." "cd .."
abbr --add ".." "cd ../.."
abbr --add "..." "cd ../../.."
abbr --add "...." "cd ../../../.."

# Common
alias cp="cp -i"
alias df="df -h"
alias l="ls -l --color"
alias la="ls -a --color"
alias ll="ls -al --color"
alias ls="ls --color"
alias free="free -m"

# Applications
alias vim="/usr/bin/nvim"
alias v="/usr/bin/vim"
alias tty-clock="tty-clock -sc -C 3"

if test "$TERM" = "xterm-ghostty"
    function ssh-ghostty
        bash -c "infocmp -x | /usr/bin/ssh $argv -- tic -x -" ^/dev/null
        /usr/bin/ssh $argv
    end
end
