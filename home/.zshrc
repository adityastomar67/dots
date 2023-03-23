# This file was created for the dotfile's sourced zshrc by adityastomar67.
# Do not edit that file directly. Instead, add any settings overrides in this file.

##--> Some options for user <--##
export OPT_THEME="No"       # Change it to "Yes", if you wants to use theme.sh script.
export USE_TMUX="No"        # Change it to "Yes", to automatically load tmux on every new instance of the terminal.
export USE_ALIAS="No"       # Pretty self explainotory.
export USE_FUNCTION="No"    # Pretty self explainotory as well.
export CUSTOM_WALL="No"     # For my personal wallpapers
export PROMPT_THEME="gh0st" # And many more like gh0st, z, 10k.
export OPENAI_API_KEY=""    # API Key for chatgpt opetions for commandline.

##--> Sourcing main config files <--##
[ -r "$HOME/.config/zsh/zshrc" ] && source "$HOME/.config/zsh/zshrc"

##--> Terminal Decorations <--##
# [ -x motivate ]                     && motivate ;echo                    # Random Motivational Quotes
[ -x $HOME/.local/bin/colorscript ] && $HOME/.local/bin/colorscript -r
