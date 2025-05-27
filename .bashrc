#!/usr/bin/bash

[ -f "/etc/bash.bashrc" ] && source "/etc/bash.bashrc"
[ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ] && debian_chroot=$(cat /etc/debian_chroot)
[ -d $HOME/.config/carapace ]&& source <(carapace _carapace)
[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"
[ -f "$HOME/.functions" ] && source "$HOME/.functions"
[ -f "$HOME/.inputrc" ] && source "$HOME/.inputrc"

set -o vi

shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=
HISTFILESIZE=

# enable history search with existing input:
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

shopt -s checkwinsize

export GOPATH="$HOME/code/go"
export PATH="$PATH:$HOME/.cargo/bin:/usr/local/go/bin:$GOPATH/bin:$HOME/go/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.local/libs"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(starship init bash)"
eval "$(fzf --bash)"
eval "$(zellij setup --generate-completion bash)"

source "$HOME/.cargo/env"

