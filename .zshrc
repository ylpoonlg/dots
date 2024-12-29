################################################################################
# oh-my-zsh - https://github.com/ohmyzsh/ohmyzsh
################################################################################
export ZSH="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$HOME/.zsh"                                         # Custom folder for user configurations

if [[ -d $ZSH ]]; then
    # oh-my-zsh Config
    zstyle ':omz:update' mode auto
    DISABLE_AUTO_TITLE="true"
    HIST_STAMPS="%d/%m-%H:%M"
    plugins=(git)

    source $ZSH/oh-my-zsh.sh
else
    # Manually source custom config files
    for config_file ("$ZSH_CUSTOM"/*.zsh(N)); do
      source "$config_file"
    done
    unset config_file
fi

################################################################################
# General zsh Config
################################################################################
setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.
setopt prompt_subst

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path 
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on                             # Speed up completions
zstyle ':completion:*' cache-path $ZSH_CUSTOM/cache

# History
HISTFILE=$ZSH_CUSTOM/.zhistory
HISTSIZE=10000
SAVEHIST=10000

WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word

################################################################################
# Key bindings
################################################################################
bindkey -v                                                      # vi bindings

# History
bindkey '^[[5~' history-beginning-search-backward               # Page up key
bindkey '^[[6~' history-beginning-search-forward                # Page down key
bindkey '^P' history-beginning-search-backward                  #
bindkey '^N' history-beginning-search-forward                   #

# Navigation
bindkey '^[[7~' beginning-of-line                               # Home key
bindkey '^[[H' beginning-of-line                                # Home key
bindkey '^A' beginning-of-line                                  #
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                                     # End key
bindkey '^[[F' end-of-line                                      # End key
bindkey '^E' end-of-line                                        #
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
fi
bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key
bindkey '^[Oc' forward-word                                     #
bindkey '^[Od' backward-word                                    #
bindkey '^[[1;5C' forward-word                                  #
bindkey '^[[1;5D' backward-word                                 #

# Edit
bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^[[Z' undo                                             # Shift+tab undo last action

################################################################################
# Theming
################################################################################
autoload -U compinit colors zcalc
compinit -d
colors

# Syntax highlighting colors
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]=fg=cyan
ZSH_HIGHLIGHT_STYLES[precommand]=fg=magenta
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=white
ZSH_HIGHLIGHT_STYLES[alias]=fg=yellow
ZSH_HIGHLIGHT_STYLES[path]=fg=blue

# Fallback prompt
PROMPT="[%F{yellow}%n%f %F{blue}%2~%f] > "

################################################################################
# Plugins
################################################################################
# Syntax Highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# History Substring Search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up			
bindkey '^[[B' history-substring-search-down

# Auto Suggestion
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#595959'

# Enable fzf integrations
source <(fzf --zsh)

# Add the fuck macro
eval $(thefuck --alias)

# Custom Prompt
eval "$(starship init zsh)"
function set_cursor_style() {
    echo -ne '\e[1 q'
}
precmd_functions+=(set_cursor_style)

# Fetch
fm6000 -f ~/.greetart -c bright_cyan -g 16 -m 2 -o "Arch Linux"

################################################################################
# Package Managed
################################################################################
# ghcup
[ -f "/home/long/.ghcup/env" ] && source "/home/long/.ghcup/env"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/long/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/long/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/long/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/long/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
