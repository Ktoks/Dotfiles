#!/usr/bin/env bash
# This script is an install of most of the things I use on a daily for work.

set -e

if [ -f "/etc/os-release" ]; then
	. /etc/os-release
	if [ "$ID_LIKE" == "arch" ]; then
		echo "Arch setup..."
		sleep 3
		sudo pacman -S --needed wezterm perl perl-test-perltidy shellcheck ruff-lsp bash-language-server base-devel cmake ninja curl otf-droid-nerd perl-app-cpanminus cosmic cosmic-session perlnavigator
		sudo cpanm Perl::LanguageServer Perl::Critic
		trap 'echo for virtual machines: sudo pacman -S qemu-full' EXIT

	elif [[ "$ID" == "fedora" ]]; then
		echo "Fedora setup..."
		sleep 3
		echo "ip_resolve=4" | sudo tee /etc/dnf/dnf.conf
		sudo dnf copr enable wezfurlong/wezterm-nightly
		sudo curl -o /etc/yum.repos.d/msprod.repo https://packages.microsoft.com/config/rhel/10/prod.repo
		sudo dnf -y install perltidy ninja-build cmake gcc make gettext curl glibc-gconv-extra openssl-devel perl-FindBin perl-IPC-Cmd perl-File-Compare perl-File-Copy perl perl-devel perl-AnyEvent-AIO perl-Coro perl-JSON perl-Moose perl-PadWalker perl-Scalar-List-Utils perl-App-cpanminus python3.14 alacarte nodejs-bash-language-server wezterm vlc vlc-plugin*x86_64 mssql-tools18
		sudo cpanm Perl::LanguageServer Perl::Critic
		sudo npm install -g perlnavigator-server
	else
		echo "Debian setup..."
		sleep 3
		sudo add-apt-repository ppa:deadsnakes/ppa -y
		sudo apt install libssl-dev build-essential unzip software-properties-common shellcheck python3.14 python3.14-venv tmux -y
	fi
fi
# bash "$HOME/.update.sh"

# echo "setting up neovim"
# sleep 3
# mkdir -p "$HOME/code"
# cd "$HOME/code"
# git clone https://github.com/neovim/neovim.git
# cd neovim
# # git checkout release-0.12
# make CMAKE_BUILD_TYPE=Release
# sudo make install
# cd

echo "Install Python uv tool"
sleep 3
curl -LsSf https://astral.sh/uv/install.sh | sh

echo 'Install Go and tools'
sleep 3
mkdir -p $HOME/Downloads
cd $HOME/Downloads
wget https://go.dev/dl/go1.27.0.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.27.0.linux-amd64.tar.gz
rm -f $HOME/Downloads/go1.27.0.linux-amd64.tar.gz
export GOPATH="$HOME/code/go" && export GOBIN="$HOME/code/go/bin" && PATH="$PATH:$GOBIN:$HOME/go/bin/:/usr/local/go/bin/"
go env -w GOAMD64=v3 GOOS=linux GOARCH=amd64 CGO_ENABLED=0 GOFLAGS="-trimpath -ldflags=-s -w"
go install golang.org/x/tools/gopls@latest
go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@latest
go install github.com/nametake/golangci-lint-langserver@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install github.com/junegunn/fzf@latest
 
echo 'Installing rust and tools'
sleep 3
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
PATH="$PATH:$HOME/.cargo/bin" && export RUSTFLAGS="-C target-cpu=native -C codegen-units=1 -C strip=symbols" && export CARGO_PROFILE_RELEASE_LTO=thin
cargo install cargo-update sd ripgrep fd-find bat stylua du-dust

echo "Installing Helix"
sleep 3
mkdir -p ~/.config/helix/runtime && curl -sL https://github.com/helix-editor/helix/archive/refs/heads/master.tar.gz | tar -xzf - -C ~/.config/helix/runtime --strip-components=2 --wildcards '*/runtime'
HELIX_DISABLE_AUTO_GRAMMAR_BUILD=1 cargo install --git https://github.com/helix-editor/helix --bins helix-term --locked
hx -g fetch && hx -g build
# echo "Don't forget the following steps for git!"
# echo 'ssh-keygen -t ed25519 -C "<useremail>"'
# echo 'eval "$(ssh-agent -s)"'
# echo 'ssh-add ~/.ssh/id_ed25519'
# echo 'cat ~/.ssh/id_ed25519.pub'
# echo 'git config --global user.name "<username>"'
# echo 'git config --global user.email "<useremail>"'
