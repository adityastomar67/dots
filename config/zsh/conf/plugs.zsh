# █▀█ █   █ █ █▀▀ █ █▄ █ █▀
# █▀▀ █▄▄ █▄█ █▄█ █ █ ▀█ ▄█

export ZSH_COMPDUMP=~/.cache/.zcompdump-$HOST
OMZ_HOME="$HOME/.cache/.oh-my-zsh"
ZINIT_HOME="$HOME/.cache/.zinit"

##--> Zinit setup <--##
if [ ! -d "$ZINIT_HOME" ]; then
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
if [ $OMZ = "Yes" ]; then
  if [ ! -d "$OMZ_HOME" ]; then
    echo "OH-MY-ZSH not found. Cloning..."
    git clone --quiet https://github.com/ohmyzsh/ohmyzsh.git $OMZ_HOME
  fi

  plugins=(
    git
    history
    web-search
    copybuffer
    dirhistory
  )
  source "$OMZ_HOME/oh-my-zsh.sh"
elif [ $OMZ = "Yes" ]; then
  [ -d $OMZ_HOME ] && rm -rf $OMZ_HOME &
fi

##--> Other Plugins <--##
command -v aws &>/dev/null && complete -C aws_completer aws
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"

# vim:filetype=zsh
