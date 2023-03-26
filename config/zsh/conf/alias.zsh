# ▄▀█ █░░ █ ▄▀█ █▀
# █▀█ █▄▄ █ █▀█ ▄█

##--> Unsetting all the aliases <--##
unalias -a

##--> Example aliases <--##
# alias "alias_name"=<alias_command>

if [ $USE_ALIAS = "Yes" ]; then

    ##--> Sudo not required for some system commands <--##
    for command in mount umount sv pacman updatedb su shutdown poweroff reboot; do
        alias $command="sudo $command"
    done
    unset command

    ##--> Use neovim for vim if present. <--##
    [ -x "$(command -v nvim)" ] && alias vim="nvim" vimdiff="nvim -d"

    if [ $(command -v exa) ]; then
        alias ls="clr && exa -al --color=always --icons --git --group-directories-first"
        alias la="exa -a --color=always --icons --group-directories-first"
        alias ll="exa -l --color=always --icons --group-directories-first"
        alias lt="exa -aT --level=2 --color=always --group-directories-first"
        alias l.="exa -a | egrep '^\.'"
        alias l="exa -l --color=always --icons --git --group-directories-first"
    fi

    if [ $(command -v lsd) ]; then
        alias ls="lsd -a --group-directories-first"
        alias ll="lsd -la --group-directories-first"
    fi

    if [ $(command -v mycli) ]; then
        alias mysql="mycli"
    fi

    if [ $(command -v logo-ls) ]; then
        alias lls="logo-ls"
        alias lla="logo-ls -l --all"
    fi

    if [ $(command -v ripgrep) ]; then
        alias grep="ripgrep"
    fi

    if [ $(command -v go-mtpfs) ]; then
        alias mount-phone="go-mtpfs $HOME/Phone &>/dev/null & disown"
    fi

    if [ $(command -v fusermount) ]; then
        alias unmount-phone="fusermount -u $HOME/Phone"
    fi

    if [ $(command -v udisksctl) ]; then
        alias mount-iso="udisksctl loop-setup -r -f"
        alias unmount-iso="udisksctl loop-delete -b"
        alias mount-ssd="udisksctl mount -b /dev/nvme0n1p1"
        alias unmount-ssd="udisksctl unmount -b /dev/nvme0n1p1"
    fi

    if [ $(command -v ranger) ]; then
        alias r="ranger"
        alias fm="ranger"
    fi

    if [ $(command -v broot) ]; then
        alias br="broot -dhp"
        alias bs="broot --sizes"
    fi

    if [ $(command -v ptsh) ]; then
        # alias ls="ptls -la"
        # alias touch=pttouch
        alias me-in=ptpwd
        alias mkdir=ptmkdir
    fi

    if [ $(command -v youtube-dl) ]; then
        alias yta-aac="youtube-dl --extract-audio --audio-format aac "
        alias yta-best="youtube-dl --extract-audio --audio-format best "
        alias yta-flac="youtube-dl --extract-audio --audio-format flac "
        alias yta-m4a="youtube-dl --extract-audio --audio-format m4a "
        alias yta-mp3="youtube-dl --extract-audio --audio-format mp3 "
        alias yta-opus="youtube-dl --extract-audio --audio-format opus "
        alias yta-vorbis="youtube-dl --extract-audio --audio-format vorbis "
        alias yta-wav="youtube-dl --extract-audio --audio-format wav "
        alias ytv-best="youtube-dl -f bestvideo+bestaudio "
    fi

    if [ $(command -v duf) ]; then
        alias df="duf"
    else
        alias df="df -h"
    fi

    if [ $(command -v yay) ]; then
        alias yaconf="yay -Pg"
        alias yaupg="yay -Syu"
        alias yas="yay -Syu --noconfirm"
        alias yain="yay -S"
        alias yains="yay -U"
        alias yare="yay -R"
        alias yarem="yay -Rns"
        alias yarep="yay -Si"
        alias yareps="yay -Ss"
        alias yaloc="yay -Qi"
        alias yalocs="yay -Qs"
        alias yalst="yay -Qe"
        alias yaorph="yay -Qtd"
        alias yainsd="yay -S --asdeps"
        alias yamir="yay -Syy"
        alias yaupd="yay -Sy"
        alias upgrade="yay -Syu"
    fi

    if [ $(command -v emacs) ]; then
        alias em="/usr/bin/emacs -nw"
        alias emacs="emacsclient -c -a 'emacs'"
        alias doomsync="~/.emacs.d/bin/doom sync"
        alias doomdoctor="~/.emacs.d/bin/doom doctor"
        alias doomupgrade="~/.emacs.d/bin/doom upgrade"
    fi

    [ $(command -v transmission-cli) ] && alias tsm='transmission-cli -D -u 10 -w ~/Downloads/torrents'
    [ $(command -v fzf) ] && alias f="clear && fzf"
    [ $(command -v sc-im) ] && alias scim='sc-im'
    [ $(command -v protonvpn-cli) ] && alias pvpn='protonvpn-cli'
    [ $(command -v neomutt) ] && alias mail="neomutt"
    [ $(command -v bat) ] && alias cat='bat'
    [ $(command -v bluetoothctl) ] && alias bt=bluetoothctl
    [ $(command -v journalctl) ] && alias jctl="journalctl -p 3 -xb"
    alias music="youtube-viewer"
    alias anime="ani-cli"
    alias flix="notflix"
    alias dmenu='dmenu -i -l 10 -fn "Iosevka Nerd Font" -p "Select File: " -nb "#282a36" -nf "#f8f8f2" -sf "#44475a" -sb "#bd93f9" '
    alias s='startx'
    alias t='bpytop'
    alias tty='tty-clock -C6 -c -t'
    alias weather='clear && curl -s wttr.in/gwalior | head -n $(($(curl -s wttr.in/gwalior | wc -l)  - 2)) | tail -n $(($(curl -s wttr.in/gwalior | wc -l)  - 4))'
    alias killl='killall -q'
    alias suck='sudo make clean install'
    alias wal='feh --bg-fill -z'
    alias du='ncdu -x --color off'
    alias lynx='lynx -cfg=~/.lynx/lynx.cfg -lss=~/.lynx/lynx.lss -vikeys'
    alias ncmpcpp='ncmpcpp ncmpcpp_directory=$HOME/.config/ncmpcpp/'
    alias spotify='spt'
    alias mocp='mocp -M "$XDG_CONFIG_HOME"/moc -O MOCDir="$XDG_CONFIG_HOME"/moc'
    alias most='du -hsx * | sort -rh | head -10'

    alias psmem='ps auxf | sort -nr -k 4'
    alias psmem10='ps auxf | sort -nr -k 4 | head -10'
    alias pscpu='ps auxf | sort -nr -k 3'
    alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
    alias paux='ps aux | grep'

    alias copy='xsel --clipboard --input'
    alias paste='xsel --clipboard --output'
    alias xclip='xclip -selection clipboard'

    alias tb="nc termbin.com 9999"
    alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
    alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

    alias ddate='date +"%R - %a, %B %d, %Y" | xclip -select clipboard && date +"%R - %a, %B %d, %Y"'
    alias dday='date +"%Y.%m.%d - " | xclip -select clipboard ; date +"%Y.%m.%d"'
    alias week='date +%V'
    alias ping='ping -c 5'
    alias fastping='ping -c 100 -s .2'
    alias rec='gpg --recv-keys --keyserver hkp://pgp.mit.edu'

    ## Additional Aliases
    alias merge="xrdb -merge ~/.Xresources"
    alias path="echo -e ${PATH//:/\\n}"
    alias findr="\fd"
    alias ip="curl ipinfo.io/ip"

    ##--> Config edit <--##
    alias nvconfig="cd ~/.config/nvim && $EDITOR init.lua"
    alias zedit="$EDITOR ~/.zshrc"
    alias bedit="$EDITOR ~/.bashrc"
    alias fedit="$EDITOR ~/.config/fish/config.fish"
    alias visudo="$EDITOR /etc/sudoers"

    ##--> System <--##
    alias please="sudo $(fc -ln -1)"
    alias _="sudo"
    alias help="man"
    alias run-help="man"
    alias c="command"
    alias x="chmod +x"
    alias :q="exit"
    alias reboot="sudo /sbin/reboot"
    alias poweroff="sudo /sbin/poweroff"
    alias halt="sudo /sbin/halt"
    alias shutdown="sudo /sbin/shutdown"
    alias lock='xscreensaver-command -lock'
    alias flighton="sudo rfkill block all"
    alias flightoff="sudo rfkill unblock all"
    alias snr="sudo service network-manager restart"
    alias logout="bspc quit"
    alias suspend="systemctl suspend; locklauncher"
    alias cls="clear"
    alias clr="clear"
    alias clean="clear"

    ##--> Get fastest mirrors <--##
    alias mirrors="sudo reflector --verbose --latest 5 --country 'United States' --age 6 --sort rate --save /etc/pacman.d/mirrorlist"
    alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
    alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
    alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

    alias kev="xev -event keyboard"

    alias cclock="watch -t -n1 'date +%T | figlet' | lolcat"
    alias tty-clock="tty-clock -S -c -C4 -D -s -n"
    alias ccbonsai="cbonsai -ilt 0.02 -c '  ,  ,  ,  ,  ' -L 5"
    alias fzr="fzf --layout=reverse --prompt ' ' --pointer '=>' --preview='less {}' --bind shift-up:preview-page-up,shift-down:preview-page-down"

    [ $(command -v ytfzf) ] && alias yt="ytfzf -t"

    ##--> Directories <--##
    [ -d ~/Documents ] && alias dc="cd ~/Documents"
    [ -d ~/Downloads ] && alias dl="cd ~/Downloads"
    [ -d ~/dotfiles ] && alias dt="cd ~/dotfiles"
    [ -d ~/Workspace ] && alias wk="cd ~/Workspace"
    [ -d ~/Projects ] && alias pj="cd ~/Projects"
    alias cd..="cd ../"
    alias cd...="cd ../../"
    alias cd....="cd ../../../"
    alias cd.....="cd ../../../../"
    alias cd......="cd ../../../../../"
    alias ~="cd ~" 2>/dev/null
    alias -="cd -" 2>/dev/null
    alias ..="cd ../"
    alias ...="cd ../../"
    alias ....="cd ../../../"
    alias .....="cd ../../../../"
    alias ......="cd ../../../../../"
    alias .1="cd -1"
    alias .2="cd -2"
    alias .3="cd -3"
    alias .4="cd -4"
    alias .5="cd -5"
    alias .6="cd -6"
    alias .7="cd -7"
    alias .8="cd -8"
    alias .9="cd -9"

    ##--> Pacman <--##
    if [ $(command -v pacman) ]; then
        alias i="pacman -S"
        alias pacupg="pacman -Syu"
        alias pacin="pacman -S"
        alias pacins="pacman -U"
        alias pacre="pacman -R"
        alias pacrem="pacman -Rns"
        alias pacrep="pacman -Si"
        alias pacreps="pacman -Ss"
        alias pacloc="pacman -Qi"
        alias paclocs="pacman -Qs"
        alias pacinsd="pacman -S --asdeps"
        alias pacmir="pacman -Syy"
        alias paclsorphans="pacman -Qdt"
        alias pacrmorphans="pacman -Rs $(pacman -Qtdq)"
        alias pacfileupg="pacman -Fy"
        alias pacfiles="pacman -F"
        alias pacls="pacman -Ql"
        alias pacown="pacman -Qo"
        alias pacupd="pacman -Sy"
        alias unlock="sudo rm /var/lib/pacman/db.lck"
        alias cleanup="pacman -Rns (pacman -Qtdq)"
    fi

    ##--> Git Stuff <--##
    if [ $(command -v git) ]; then
        [ -d $HOME/Downloads/git-repos/ ] && alias clone="cd $HOME/Downloads/git-repos/ && git clone"
        alias commit="git commit -m"
        alias push="git push origin"
        alias pull="git pull origin"
        alias g=git
        alias ga="git add"
        alias gaa="git add --all"
        alias gam="git am"
        alias gama="git am --abort"
        alias gamc="git am --continue"
        alias gams="git am --skip"
        alias gamscp="git am --show-current-patch"
        alias gap="git apply"
        alias gapa="git add --patch"
        alias gapt="git apply --3way"
        alias gau="git add --update"
        alias gav="git add --verbose"
        alias gb="git branch"
        alias gbD="git branch -D"
        alias gba="git branch -a"
        alias gbd="git branch -d"
        alias gbda='git branch --no-color --merged | command grep -vE "^([+*]|\s*($(git_main_branch)|$(git_develop_branch))\s*$)" | command xargs git branch -d 2>/dev/null'
        alias gbl="git blame -b -w"
        alias gbnm="git branch --no-merged"
        alias gbr="git branch --remote"
        alias gbs="git bisect"
        alias gbsb="git bisect bad"
        alias gbsg="git bisect good"
        alias gbsr="git bisect reset"
        alias gbss="git bisect start"
        alias gc="git commit -v"
        alias "gc!"="git commit -v --amend"
        alias gca="git commit -v -a"
        alias "gca!"="git commit -v -a --amend"
        alias gcam="git commit -a -m"
        alias "gcan!"="git commit -v -a --no-edit --amend"
        alias "gcans!"="git commit -v -a -s --no-edit --amend"
        alias gcas="git commit -a -s"
        alias gcasm="git commit -a -s -m"
        alias gcb="git checkout -b"
        alias gcd="git checkout $(git_develop_branch)"
        alias gcf="git config --list"
        alias gclr="git clone --recurse-submodules"
        alias gcl="git clone --quiet"
        alias gcld="git clone --depth"
        alias gclean="git clean -id"
        alias gcm="git checkout $(git_main_branch)"
        alias gcmsg="git commit -m"
        alias "gcn!"="git commit -v --no-edit --amend"
        alias gco="git checkout"
        alias gcor="git checkout --recurse-submodules"
        alias gcount="git shortlog -sn"
        alias gcp="git cherry-pick"
        alias gcpa="git cherry-pick --abort"
        alias gcpc="git cherry-pick --continue"
        alias gcs="git commit -S"
        alias gcsm="git commit -s -m"
        alias gcss="git commit -S -s"
        alias gcssm="git commit -S -s -m"
        alias gd="git diff"
        alias gdca="git diff --cached"
        alias gdct="git describe --tags $(git rev-list --tags --max-count=1)"
        alias gdcw="git diff --cached --word-diff"
        alias gds="git diff --staged"
        alias gdt="git diff-tree --no-commit-id --name-only -r"
        alias gdup="git diff @{upstream}"
        alias gdw="git diff --word-diff"
        alias gf="git fetch"
        alias gfa="git fetch --all --prune --jobs=10"
        alias gfg="git ls-files | grep"
        alias gfo="git fetch origin"
        alias gg="git gui citool"
        alias gga="git gui citool --amend"
        alias ggpull='git pull origin "$(git_current_branch)"'
        alias ggpur=ggu
        alias ggpush='git push origin "$(git_current_branch)"'
        alias ggsup="git branch --set-upstream-to=origin/$(git_current_branch)"
        alias ghh="git help"
        alias gignore="git update-index --assume-unchanged"
        alias gignored='git ls-files -v | grep "^[[:lower:]]"'
        alias git-svn-dcommit-push="git svn dcommit && git push github $(git_main_branch):svntrunk"
        alias gk="\gitk --all --branches &!"
        alias gke="\gitk --all $(git log -g --pretty=%h) &!"
        alias gl="git pull"
        alias glg="git log --stat"
        alias glgg="git log --graph"
        alias glgga="git log --graph --decorate --all"
        alias glgm="git log --graph --max-count=10"
        alias glgp="git log --stat -p"
        alias glo="git log --oneline --decorate"
        alias globurl="noglob urlglobber "
        alias glod='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'\'
        alias glods='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'\'' --date=short'
        alias glog='git log --oneline --decorate --graph'
        alias gloga='git log --oneline --decorate --graph --all'
        alias glol='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'\'
        alias glola='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'\'' --all'
        alias glols='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'\'' --stat'
        alias glp=_git_log_prettily
        alias glum='git pull upstream $(git_main_branch)'
        alias gm='git merge'
        alias gma='git merge --abort'
        alias gmom='git merge origin/$(git_main_branch)'
        alias gmtl='git mergetool --no-prompt'
        alias gmtlvim='git mergetool --no-prompt --tool=vimdiff'
        alias gmum='git merge upstream/$(git_main_branch)'
        alias gp='git push'
        alias gpd='git push --dry-run'
        alias gpf='git push --force-with-lease'
        alias 'gpf!'='git push --force'
        alias gpoat='git push origin --all && git push origin --tags'
        alias gpr='git pull --rebase'
        alias gpristine='git reset --hard && git clean -dffx'
        alias gpsup='git push --set-upstream origin $(git_current_branch)'
        alias gpu='git push upstream'
        alias gpv='git push -v'
        alias gr='git remote'
        alias gra='git remote add'
        alias grb='git rebase'
        alias grwh='git rm --cached `git ls-files -i -c --exclude-from=.gitignore`'
        alias grwhx='git ls-files -i -c --exclude-from=.gitignore | xargs git rm --cached'
        alias grad='git rm -r --cached . && git add .'
        alias grba='git rebase --abort'
        alias grbc='git rebase --continue'
        alias grbd='git rebase $(git_develop_branch)'
        alias grbi='git rebase -i'
        alias grbm='git rebase $(git_main_branch)'
        alias grbo='git rebase --onto'
        alias grbom='git rebase origin/$(git_main_branch)'
        alias grbs='git rebase --skip'
        alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
        alias grev='git revert'
        alias grh='git reset'
        alias grhh='git reset --hard'
        alias grm='git rm'
        alias grmc='git rm --cached'
        alias grmv='git remote rename'
        alias groh='git reset origin/$(git_current_branch) --hard'
        alias grrm='git remote remove'
        alias grs='git restore'
        alias grset='git remote set-url'
        alias grss='git restore --source'
        alias grst='git restore --staged'
        alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'
        alias gru='git reset --'
        alias grup='git remote update'
        alias grv='git remote -v'
        alias gsb='git status -sb'
        alias gsd='git svn dcommit'
        alias gsh='git show'
        alias gsi='git submodule init'
        alias gsps='git show --pretty=short --show-signature'
        alias gsr='git svn rebase'
        alias gss='git status -s'
        alias gst='git status'
        alias gsta='git stash push'
        alias gstaa='git stash apply'
        alias gstall='git stash --all'
        alias gstc='git stash clear'
        alias gstd='git stash drop'
        alias gstl='git stash list'
        alias gstp='git stash pop'
        alias gsts='git stash show --text'
        alias gstu='gsta --include-untracked'
        alias gsu='git submodule update'
        alias gsw='git switch'
        alias gswc='git switch -c'
        alias gswd='git switch $(git_develop_branch)'
        alias gswm='git switch $(git_main_branch)'
        alias gtl='gtl(){ git tag --sort=-v:refname -n -l "${1}*" }; noglob gtl'
        alias gts='git tag -s'
        alias gtv='git tag | sort -V'
        alias gunignore='git update-index --no-assume-unchanged'
        alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
        alias gup='git pull --rebase'
        alias gupa='git pull --rebase --autostash'
        alias gupav='git pull --rebase --autostash -v'
        alias gupv='git pull --rebase -v'
        alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
        alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"'
    fi

    alias ldot="ls -ld .*"
    alias lS="ls -1FSsh"
    alias lart="ls -1Fcart"
    alias lrt="ls -1Fcrt"

    ##--> Shell Change <--##
    alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
    alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"
    alias tofish="sudo chsh $USER -s /bin/fish && echo 'Now log out.'"

    ##--> Command line shortcuts <--##
    alias -g H="| head"
    alias -g T="| tail"
    alias -g G="| grep"
    alias -g S="| sed"
    alias -g L="| less"
    alias -g M="| most"
    alias -g LL="2>&1 | less"
    alias -g CA="2>&1 | bat -A"
    alias -g NE="2> /dev/null"
    alias -g NUL="> /dev/null 2>&1"
    alias -g P="2>&1| pygmentize -l pytb"

    alias dud="du -d 1 -h"
    alias ff="find . -type f -name"

    alias h="history"
    alias hgrep="fc -El 0 | grep"
    alias p="ps -f"
    alias sorter="sort -n -r"
    alias unexport="unset"

    if [ $(command -v rsync) ]; then
        alias cp="rsync -WavP --human-readable --progress"
    fi

    if [ $(command -v trash) ]; then
        alias rm="trash --trash-dir='$HOME/.Trash' --recursive"
    fi

    if [ $(command -v zathura) ]; then
        alias zth=zathura
        alias pdf=zathura
    fi

    alias ps=gv
    alias dvi=xdvi
    alias chm=xchm
    alias djvu=djview

    alias zip="unzip -l"
    alias rar="unrar l"
    alias tar.gz="echo "
    alias ace="unace l"

    alias gping="ping -c5 google.com"

    alias killconk="killall conky"

    ##--> Languages <--##
    alias java="java $JDK_JAVA_OPTIONS"
    alias py=python

    ##--> Tmux Aliases <--##
    if [ $(command -v tmux) ]; then
        alias attach="tmux attach -t"
        alias ts="tmux ls"
    fi

    ##--> Updating <--##
    alias grub-up="sudo grub-mkconfig -o /boot/grub/grub.cfg"
    alias font-up='sudo fc-cache -fv'
    alias pip-up="sudo pip3 list --outdated | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install -U"
    alias npm-up="sudo npm install npm@latest -g"
    alias upgrade="npm-up && pip-up && pacman -Syyu"
    alias update="pacman -Syyu"

    ##--> Greping <--##
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias grepin="grep -i"
    alias sgrep="grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} "
    alias egrep='egrep --color=auto'

    ##--> More Flags <--##
    alias mv="mv -i"
    alias tar="tar tf"
    alias nano="nano -00x"
    alias wget="wget -c"
    alias startx='startx -- -keeptty >~/.xorg.log 2>&1'
    alias calc="bc -l"
    alias free="free -m"

    ##--> Extras <--##
    alias mantenimiento="yay -Sc && sudo pacman -Scc"
    alias purga="sudo pacman -Rns $(pacman -Qtdq) ; sudo fstrim -av"
fi

# vim:filetype=zsh
