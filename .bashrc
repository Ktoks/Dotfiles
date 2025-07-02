#!/usr/bin/bash

export GOPATH="$HOME/code/go"
export PATH="$PATH:$HOME/.cargo/bin:/usr/local/go/bin:$GOPATH/bin:$HOME/go/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.local/libs"

[ -f "/etc/bash.bashrc" ] && source "/etc/bash.bashrc"
[ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ] && debian_chroot=$(cat /etc/debian_chroot)
if [ -f "$(which carapace)"  ]; then
  [ ! -s "$HOME/.cache/carapace/init" ] && carapace _carapace > "$HOME/.cache/carapace/init"
  source "$HOME/.cache/carapace/init"
fi
[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"
[ -f "$HOME/.functions" ] && source "$HOME/.functions"
[ -f "$HOME/.inputrc" ] && source "$HOME/.inputrc"

set -o vi

shopt -s histappend
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=
HISTFILESIZE=

# enable history search with existing input:
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

shopt -s checkwinsize

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(starship init bash)"
# eval "$(fzf --bash)"
eval "$(tv init bash)"
eval "$(zellij setup --generate-completion bash)"

source "$HOME/.cargo/env"

