#!/usr/bin/env bash

export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$HOME/.local/lib:$HOME/.local/bin"

[ -d /opt/mssql-tools18/bin ] && export PATH="$PATH:/opt/mssql-tools18/bin"
[ -f "/etc/bash.bashrc" ] && source "/etc/bash.bashrc"
[ "${debian_chroot:-}" = "" ] && [ -r /etc/debian_chroot ] && debian_chroot=$(cat /etc/debian_chroot)
[ -d /usr/local/go/ ] && export gopath="$HOME/code/go" && path="$path:/usr/local/go/bin:$gopath/bin:$HOME/go/bin/:"
[ "$(command -v cargo)" ] && PATH="$PATH:$HOME/.cargo/bin" && export RUSTFLAGS="-C target-cpu=native"
[ -d "$HOME/.fzf/bin/" ] && PATH="$PATH:$HOME/.fzf/bin"
[ "$(command -v fzf)" ] && eval "$(fzf --bash)"
[ "$(command -v zellij)" ] && eval "$(zellij setup --generate-completion bash)"
[ -f "$HOME/.ops/scripts/bash_completion.sh" ] && export OPS_DIR="$HOME/.ops" && export PATH="$HOME/.ops/bin:$PATH" && source "$HOME/.ops/scripts/bash_completion.sh"

# Setup ls colors
if [ -f ~/.ls_colors ]; then
    eval "$(dircolors -b ~/.ls_colors)"
# else
#     export LS_COLORS='di=1;97;100:ln=36:ex=31'
fi

if [ "$(command -v carapace)" ]; then
  [ ! -s "$HOME/.cache/carapace/init" ] && carapace _carapace > "$HOME/.cache/carapace/init"
  source "$HOME/.cache/carapace/init"
fi

# --- Source Configuration Files ---
for file in "/etc/bashrc" "$HOME/.aliases" "$HOME/.cargo/env" "$HOME/.functions" "$HOME/.nav" "$HOME/.prompt" "$HOME/.fzf_commands.sh"; do
    [ -f "$file" ] && source "$file"
done

[[ -r "/usr/share/bash-completion/bash_completion" ]] && source "/usr/share/bash-completion/bash_completion"

export EDITOR="/usr/sbin/hx"
export TERM='xterm-256color'

set -o vi

shopt -s histappend
shopt -s checkwinsize
HISTCONTROL="ignoreboth:erasedups"
HISTSIZE=''
HISTFILESIZE=''

# up arrow for history match current command
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# shopt -s autocd
shopt -s cdspell
# shopt -s dotglob
# shopt -s globstar

[ -d "$HOME/.nvm" ] && export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
[ -d "/opt/minecraft" ] && PATH="$PATH:/opt/minecraft"
if [ -f ~/.todo ] && [ -s ~/.todo ]; then
    echo "--- TODOs ---"
    cat ~/.todo
    echo "-------------"
fi

bind -f ~/.inputrc
