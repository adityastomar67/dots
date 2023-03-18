# ▀█▀ █ █ █▀▀ █▀▄▀█ █▀▀   █▀ █ █
#  █  █▀█ ██▄ █ ▀ █ ██▄ ▄ ▄█ █▀█

if [ $OPT_THEME = "Yes" ]; then

    ##--> Theme.sh Config <--##
    if command -v theme.sh >/dev/null; then
        [ -e ~/.theme_history ] && theme.sh "$(theme.sh -l | tail -n1)"

        # Optional
        last_theme() {
            theme.sh "$(theme.sh -l | tail -n2 | head -n1)"
        }
        zle -N last_theme

        # Bind C-o to the last theme.
        bindkey '^O' last_theme
        
        alias th='theme.sh -i'

        # Interactively load a light theme
        alias thl='theme.sh --light -i'

        # Interactively load a dark theme
        alias thd='theme.sh --dark -i'
    else
        sudo curl -Lo /usr/bin/theme.sh 'https://git.io/JM70M' && sudo chmod +x /usr/bin/theme.sh
    fi
fi

# vim:filetype=zsh
