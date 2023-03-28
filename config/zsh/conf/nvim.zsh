# █▄ █ █ █ █ █▀▄▀█ ▄▄ █▀ █ █ █ █ ▀█▀ █▀▀ █ █ █▀▀ █▀█
# █ ▀█ ▀▄▀ █ █ ▀ █   ▄█ ▀▄▀▄▀ █  █  █▄▄ █▀█ ██▄ █▀▄
# A utility function for easy nvim config switching by @elijahmanor

##--> Check for user choice <--##
if [ $MULTI_NEOVIM = "Yes" ]; then
# if [ $(nvim --version | grep -oP '(?<=^NVIM v)[0-9|.]+') ]

    ##--> Clone configs if not found <--##
    [ ! -d ~/.config/LazyVim ] && git clone --quiet https://github.com/LazyVim/starter ~/.config/LazyVim \
        && echo "Cloning LazyVim configs..."
    [ ! -d ~/.config/NvChad ] && git clone --quiet --depth 1 https://github.com/adityastomar67/NvChad ~/.config/NvChad \
        && echo "Cloning NvChad configs..."
    [ ! -d ~/.config/LazyNV ] && git clone --quiet --depth 1 https://github.com/adityastomar67/LazyNV ~/.config/LazyNV \
        && echo "Cloning LazyNV configs..."
    [ ! -d ~/.config/AstroNvim ] && git clone --quiet --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/AstroNvim \
        && echo "Cloning AstroNvim configs..."

    function nvims() {
        ##--> Pre check for flags <--##
        if [ $# -gt 0 ]; then
            case "$1" in
            -a | --astro)
                NVIM_APPNAME=AstroNvim nvim
                ;;
            -l | --lazy)
                NVIM_APPNAME=LazyVim nvim
                ;;
            -c | --chad)
                NVIM_APPNAME=NvChad nvim
                ;;
            -n | --nv)
                NVIM_APPNAME=LazyNV nvim
                ;;
            ?)
                echo "No config found for the choice!" >&2
                exit 1
                ;;
            esac
        else
            echo "No args"
        fi

        items=("default" "LazyNV" "LazyVim" "NvChad" "AstroNvim")
        config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
        if [[ -z $config ]]; then
            echo "Nothing selected"
            return 0
        elif [[ $config == "default" ]]; then
            config=""
        fi
        NVIM_APPNAME=$config nvim $@
    }

    bindkey -s ^a "nvims\n"
    alias vs=nvims

elif [ $MULTI_NEOVIM = "No" ]; then

    ##--> Remove the config data if found <--##
    [ -d ~/.config/LazyVim ] && rm -rf ~/.config/LazyVim
    [ -d ~/.config/NvChad ] && rm -rf ~/.config/NvChad
    [ -d ~/.config/LazyNV ] && rm -rf ~/.config/LazyNV
    [ -d ~/.config/AstroNvim ] && rm -rf ~/.config/AstroNvim
fi

# vim:filetype=zsh
