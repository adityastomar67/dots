# █▀█ █   █ █ █▀▀ █ █▄ █ █▀
# █▀▀ █▄▄ █▄█ █▄█ █ █ ▀█ ▄█

export ZSH_COMPDUMP=~/.cache/.zcompdump-$HOST
OMZ_HOME="$ZDOTDIR/oh-my-zsh"
ZINIT_HOME="$ZDOTDIR/zinit"

##--> Zinit setup <--##
if [ ! -d "$ZINIT_HOME" ]
then
    echo "ZINIT not found. Cloning..."
    git clone --depth 1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"
alias use='zinit light'
alias ice='zinit ice'
alias load='zinit load'

ice depth"1"
use zsh-users/zsh-completions
use hlissner/zsh-autopair
use zdharma-continuum/fast-syntax-highlighting
use MichaelAquilina/zsh-you-should-use
use Aloxaf/fzf-tab

ice wait'3' lucid
load zsh-users/zsh-history-substring-search

ice wait'3' lucid
load zsh-users/zsh-autosuggestions

ice wait'3' lucid
load zsh-users/zsh-syntax-highlighting

ice wait'2' lucid
load zdharma-continuum/history-search-multi-word

ice wait'5' lucid
unalias use ice load

##--> OMZ setup <--##
if [ ! -d "$OMZ_HOME" ]
then
    echo "OH-MY-ZSH not found. Cloning..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

plugins=(
  git
  history
  web-search
  copybuffer
  dirhistory
)
source "$OMZ_HOME/oh-my-zsh.sh"

##--> Other Plugins <--##
command -v aws &>/dev/null && complete -C aws_completer aws
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"

# vim:filetype=zsh
