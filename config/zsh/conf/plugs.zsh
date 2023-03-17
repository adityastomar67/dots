# █▀█ █   █ █ █▀▀ █ █▄ █ █▀
# █▀▀ █▄▄ █▄█ █▄█ █ █ ▀█ ▄█

OMZ_HOME="$HOME/.oh-my-zsh"
ZINIT_HOME="$HOME/.zinit"

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

autoload compinit
compinit

use hlissner/zsh-autopair
use zdharma-continuum/fast-syntax-highlighting
use MichaelAquilina/zsh-you-should-use
use Aloxaf/fzf-tab

ice wait'3' lucid
load zsh-users/zsh-history-substring-search

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
  z
  git
  history
  web-search
  copybuffer
  dirhistory
)
source "$OMZ_HOME/oh-my-zsh.sh"

##--> Offline Plugins <--##
source ~/.config/zsh/plug/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/plug/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/plug/zsh-history-substring-search/zsh-history-substring-search.zsh

##--> Other Plugins <--##
command -v aws &>/dev/null && complete -C aws_completer aws
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"

# vim:filetype=zsh
