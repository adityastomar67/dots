#   ▀█ █▀ █ █ █▀█ █▀▀
# ▄ █▄ ▄█ █▀█ █▀▄ █▄▄

##--> Explicitly launching of tmux <--##
source "$HOME/.config/zsh/conf/tmux.zsh" || return

##--> Sourcing config files <--##
while read F
do
  [ -f "$HOME/.config/zsh/conf/$F.zsh" ] && source "$HOME/.config/zsh/conf/$F.zsh"
done <<-EOF
    opts
    plugs
    theme
    keys
    env
    prompt
    fzf
EOF

##--> Sourcing other files <--##
[ -f "$HOME/.config/zsh/alias.zsh" ]     && source "$HOME/.config/zsh/alias.zsh"      # Aliases - For a full list of active aliases, run `alias`.
[ -f "$HOME/.config/zsh/function.zsh" ]  && source "$HOME/.config/zsh/function.zsh"   # functions to improve productivity
[ -f "$HOME/.temp_src" ]                 && source "$HOME/.temp_src"                  # For temporary offline aliases

##--> Final Options <--##
echo -en "\x1b[2J\x1b[1;1H" ;echo   # For faster clearing the Terminal
set -o vi                           # Vi-mode

# vim:filetype=zsh
