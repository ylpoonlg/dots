#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -la --color=auto'
alias grep='grep --color=auto'

alias vim='nvim'
alias v='/bin/vim'

PS1='[\u@\h \W]\$ '
eval "$(starship init bash)"

if [ "$RUNBASH" != "1" ]; then
    exec /usr/bin/fish
fi
