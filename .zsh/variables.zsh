# Colors
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r
export LS_COLORS="di=1;94:fi=0;37:ln=0;96:ex=4;33:tw=00:ow=00"

# PHP
export PHP_FPM_USER="www"
export PHP_FPM_GROUP="www"
export PHP_FPM_LISTEN_MODE="0660"
export PHP_MEMORY_LIMIT="512M"
export PHP_MAX_UPLOAD="50M"
export PHP_MAX_FILE_UPLOAD="200"
export PHP_MAX_POST="100M"
export PHP_DISPLAY_ERRORS="On"
export PHP_DISPLAY_STARTUP_ERRORS="On"
export PHP_ERROR_REPORTING="E_COMPILE_ERROR\|E_RECOVERABLE_ERROR\|E_ERROR\|E_CORE_ERROR"
export PHP_CGI_FIX_PATHINFO=0
export _JAVA_AWT_WM_NONREPARENTING=1

# FZF
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#6C7380,fg+:#FF8F40,bg:-1,bg+:#1f222a
  --color=hl:-1,hl+:#59C2FF,info:#E6B673,marker:#E6B673
  --color=prompt:#59C2FF,spinner:#F07178,pointer:#59C2FF,header:#F07178
  --color=border:#3b414a,label:#aeaeae,query:#BFBDB6
  --border="sharp" --border-label="" --preview-window="border-rounded" --prompt="❯ "
  --marker="✭" --pointer="➤" --separator="─" --scrollbar="┃"
  --layout="reverse" --info="right"
  --height ~40%
  '
