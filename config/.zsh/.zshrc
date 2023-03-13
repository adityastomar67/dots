#    ███████╗ ██████╗██╗  ██╗██████╗  █████╗
#    ╚════██║██╔════╝██║  ██║██╔══██╗██╔══██╗
#      ███╔═╝╚█████╗ ███████║██████╔╝██║  ╚═╝
#    ██╔══╝   ╚═══██╗██╔══██║██╔══██╗██║  ██╗
# ██╗███████╗██████╔╝██║  ██║██║  ██║╚█████╔╝
# ╚═╝╚══════╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚════╝

## Sourcing config files
while read file
do
  [ -f "$HOME/.config/.zsh/$file.zsh" ] && source "$HOME/.config/.zsh/$file.zsh"
done <<-EOF
    plugs
    # theme
    env
    opts
    keys
    prompt
    fzf
EOF

## Explicitly launching of tmux
source $HOME/.config/.zsh/tmux.zsh

## Sourcing other files
[ -f "$HOME/.config/.zsh/.aliases" ]    && source $HOME/.config/.zsh/.aliases     # Aliases - For a full list of active aliases, run `alias`.
[ -f "$HOME/.config/.zsh/.functions" ]  && source $HOME/.config/.zsh/.functions   # functions to improve productivity
[ -f "$HOME/.temp_src" ]                 && source $HOME/.temp_src

## Calling scrpits and Operations
echo -en "\x1b[2J\x1b[1;1H" ;echo # For faster clearing the Terminal

motivate ;echo                    # Random Motivational Quotes
# header ;echo                      # Header for adityastomar67
set -o vi                         # Vi-mode
# ~/.local/bin/colorscript -r