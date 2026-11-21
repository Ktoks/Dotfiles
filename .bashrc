#!/usr/bin/env bash

if command -v gh &> /dev/null; then
    export GITHUB_TOKEN="$(gh auth token 2>/dev/null)"
    export COPILOT_GITHUB_TOKEN="$GITHUB_TOKEN"
fi

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$HOME/.local/lib:$HOME/.local/bin"

[[ -d /opt/mssql-tools18/bin ]] && export PATH="$PATH:/opt/mssql-tools18/bin"
[[ -d /usr/local/cuda/bin ]] && export PATH="$PATH:/usr/local/cuda/bin"
[[ -d /usr/local/cuda-13.3/bin ]] && export PATH="$PATH:/usr/local/cuda-13.3/bin"
[[ -d "$HOME/.fzf/bin" ]] && export PATH="$PATH:$HOME/.fzf/bin"

if [[ -f /usr/local/go/bin/go ]]; then
    export GOPATH="$HOME/code/go"
    export GOBIN="$GOPATH/bin"
    export PATH="$PATH:$GOBIN:$HOME/go/bin:/usr/local/go/bin"
fi

if command -v cargo &> /dev/null; then
    export PATH="$PATH:$HOME/.cargo/bin"
    export RUSTFLAGS="-C target-cpu=native -C codegen-units=1 -C strip=symbols"
    export CARGO_PROFILE_RELEASE_LTO="thin"
fi

[[ -f "/etc/bash.bashrc" ]] && source "/etc/bash.bashrc"
[[ -z "${debian_chroot:-}" && -r /etc/debian_chroot ]] && debian_chroot="$(< /etc/debian_chroot)"

[[ -d "/usr/local/cuda-13.3/lib64" ]] && export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/local/cuda-13.3/lib64"

if [[ -e "/usr/sbin/hx" ]]; then
    export EDITOR="/usr/sbin/hx" SYSTEMD_EDITOR="/usr/sbin/hx" VISUAL="/usr/sbin/hx"
elif [[ -e "/usr/bin/hx" ]]; then
    export EDITOR="/usr/bin/hx" SYSTEMD_EDITOR="/usr/bin/hx" VISUAL="/usr/bin/hx"
else
    export EDITOR="/usr/bin/vi" SYSTEMD_EDITOR="/usr/bin/vi" VISUAL="/usr/bin/vi"
fi

export TERM='xterm-256color'
export LS_COLORS='di=1;97;100:ln=36:ex=31'

command -v fzf &> /dev/null && eval "$(fzf --bash)"
command -v zellij &> /dev/null && eval "$(zellij setup --generate-completion bash)"

shopt -s histappend
shopt -s cmdhist
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=-1
HISTFILESIZE=-1
HISTFILE="$HOME/.bash_history"

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

shopt -s cdable_vars 2>/dev/null

[[ -d "$HOME/.nvm" ]] && export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"

if [[ -s ~/.todo ]]; then
    echo -e "\033[36m--- TODOs ---\033[0m"
    cat ~/.todo
    echo -e "\033[36m-------------\033[0m"
fi

for file in "$HOME/.aliases" "$HOME/.cargo/env" "$HOME/.functions" "$HOME/.nav" "$HOME/.prompt" "$HOME/.fzf_commands.sh"; do
    [[ -f "$file" ]] && source "$file"
done

set -o vi

[[ -f "$HOME/.inputrc" ]] && bind -f ~/.inputrc

