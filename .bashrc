#!/usr/bin/env bash

export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$HOME/.local/lib:$HOME/.local/bin"

[ -f "/etc/bashrc" ] && source "/etc/bashrc"
[ -f "/etc/bash.bashrc" ] && source "/etc/bash.bashrc"
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
[ "${debian_chroot:-}" = "" ] && [ -r /etc/debian_chroot ] && debian_chroot=$(cat /etc/debian_chroot)
[ "$(command -v go)" ] && go env -w GOFLAGS=-buildvcs=false && export GOOS="linux" && export GOPATH="$HOME/code/go" && PATH="$PATH:/usr/local/go/bin:$GOPATH/bin:$HOME/go/bin/"
[ "$(command -v cargo)" ] && PATH="$PATH:$HOME/.cargo/bin" && export RUSTFLAGS="-C target-cpu=native"
[ "$(command -v fzf)" ] && eval "$(fzf --bash)"
[ "$(command -v zellij)" ] && eval "$(zellij setup --generate-completion bash)"

if [ "$(command -v carapace)" ]; then
  [ ! -s "$HOME/.cache/carapace/init" ] && carapace _carapace > "$HOME/.cache/carapace/init"
  source "$HOME/.cache/carapace/init"
fi

[[ -r "/usr/share/bash-completion/bash_completion" ]] && source "/usr/share/bash-completion/bash_completion"

[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"
[ -f "$HOME/.functions" ] && source "$HOME/.functions"
[ -f "$HOME/.inputrc" ] && source "$HOME/.inputrc"
[ -f "$HOME/.prompt" ] && source "$HOME/.prompt"

set -o vi

shopt -s histappend
shopt -s checkwinsize
HISTCONTROL="ignoreboth:erasedups"
HISTSIZE=''
HISTFILESIZE=''

# cd niceties
shopt -s autocd
shopt -s cdspell
# shopt -s dotglob
# shopt -s globstar

# enable history search with existing input:
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

[ -d "$HOME/.nvm" ] && export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm

# OPS config
[ -d $HOME/.ops ] && export OPS_DIR="$HOME/.ops" && export PATH="$HOME/.ops/bin:$PATH" && source "$HOME/.ops/scripts/bash_completion.sh"
