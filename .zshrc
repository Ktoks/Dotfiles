#!/usr/bin/env zsh

if (( $+commands[gh] )); then
    export GITHUB_TOKEN="$(gh auth token 2>/dev/null)"
    export COPILOT_GITHUB_TOKEN="$GITHUB_TOKEN"
fi

typeset -U path
path=(
    /usr/local/sbin
    /usr/local/bin
    /usr/sbin
    /usr/bin
    /sbin
    /bin
    "$HOME/.local/lib"
    "$HOME/.local/bin"
    $path
)

[[ -d /opt/mssql-tools18/bin ]] && path+=("/opt/mssql-tools18/bin")
[[ -d /usr/local/cuda/bin ]] && path+=("/usr/local/cuda/bin")
[[ -d /usr/local/cuda-13.3/bin ]] && path+=("/usr/local/cuda-13.3/bin")
[[ -d "$HOME/.fzf/bin" ]] && path+=("$HOME/.fzf/bin")

if [[ -f /usr/local/go/bin/go ]]; then
    export GOPATH="$HOME/code/go"
    export GOBIN="$GOPATH/bin"
    path+=("$GOBIN" "$HOME/go/bin" /usr/local/go/bin)
fi

if (( $+commands[cargo] )); then
    path+=("$HOME/.cargo/bin")
    export RUSTFLAGS="-C target-cpu=native -C codegen-units=1 -C strip=symbols"
    export CARGO_PROFILE_RELEASE_LTO="thin"
fi

[[ -f "/etc/zsh/zshrc" ]] && source "/etc/zsh/zshrc"
[[ -z "${debian_chroot:-}" && -r /etc/debian_chroot ]] && debian_chroot="$(< /etc/debian_chroot)"

# NVIDIA / Graphics adjustments (uncomment if os-release is sourced)
# [[ -f /etc/os-release ]] && source /etc/os-release
# [[ "$ID" == "fedora" ]] && export __GLX_VENDOR_LIBRARY_NAME="nvidia" WLR_NO_HARDWARE_CURSORS="1"

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

(( $+commands[fzf] )) && eval "$(fzf --zsh)"
(( $+commands[zellij] )) && eval "$(zellij setup --generate-completion zsh)"

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="$HOME/.zsh_history"

setopt CORRECT
setopt CDable_vars

[[ -d "$HOME/.nvm" ]] && export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"

if [[ -s ~/.todo ]]; then
    print -P "%F{cyan}--- TODOs ---%f"
    cat ~/.todo
    print -P "%F{cyan}-------------%f"
fi

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' menu select

for file in "$HOME/.aliases" "$HOME/.cargo/env" "$HOME/.functions" "$HOME/.nav" "$HOME/.zprompt" "$HOME/.fzf_commands.sh"; do
    [[ -f "$file" ]] && source "$file"
done

# Enable Vi keybindings
bindkey -v
export KEYTIMEOUT=1 # 10ms ESC delay

# Bind arrow keys for history search in insert mode (covering all terminal escape variants)
for key ('^[[A' '^[OA' '\e[A') bindkey -M viins "$key" history-search-backward
for key ('^[[B' '^[OB' '\e[B') bindkey -M viins "$key" history-search-forward

# Bind 'k' and 'j' in Command Mode for prefix search
bindkey -M vicmd 'k' history-search-backward
bindkey -M vicmd 'j' history-search-forward

# Shift+Tab glob expansion
bindkey '^[[Z' expand-word

[[ -f "$HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && source "$HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[[ -f "$HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "$HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
