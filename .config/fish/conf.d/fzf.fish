# fzf set up

set -x FZF_DEFAULT_OPTS '
--color=fg:#6C7380,fg+:#FF8F40,bg:-1,bg+:#1f222a
--color=hl:-1,hl+:#59C2FF,info:#E6B673,marker:#E6B673
--color=prompt:#59C2FF,spinner:#F07178,pointer:#59C2FF,header:#F07178
--color=border:#3b414a,label:#aeaeae,query:#BFBDB6
--border="sharp" --border-label="" --preview-window="border-rounded" --prompt="❯ "
--marker="✭" --pointer="➤" --separator="─" --scrollbar="┃"
--layout="reverse" --info="right"
--height=~40%'

fzf --fish | source
