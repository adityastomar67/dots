# This file was created by the dotfiles sourced zshrc by adityastomar67.
# Do not edit that file directly. Instead, add any settings overrides in this file.

##--> Some options for user experience <--##
export OPT_THEME="No" # Change it to "Yes", if you wants to use theme.sh script.
export USE_TMUX="No"  # Change it to "Yes", to automatically load tmux on every new instance of the terminal
export USE_ALIAS="NO" # Pretty self explainotory

##--> Sourcing main config files <--##
if [ -r "$HOME/.config/zsh/.zshrc" ]; then
    source "$HOME/.config/zsh/.zshrc"
fi

# [ -x motivate ]                     && motivate ;echo                    # Random Motivational Quotes
# [ -x header ]                       && header ;echo                      # Header for adityastomar67
[ -x $HOME/.local/bin/colorscript ] && $HOME/.local/bin/colorscript -r