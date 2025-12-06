#!/usr/bin/env bash
# This script is an install of most of the things I use on a daily for work.

set -e

# echo "setting up rust"
# sleep 3
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# source "$HOME/.profile"

cd "$HOME"
mkdir -p code
cd code

if [ -f "/etc/os-release" ]; then
	. /etc/os-release
	if [ "$ID_LIKE" == "arch" ]; then
    	echo "Arch setup..."
    	sleep 3
		sudo pacman -S --needed python-pip wezterm ripgrep fd dust stylua zellij perl perl-test-perltidy shellcheck ruff-lsp bash-language-server helix fzf base-devel cmake ninja curl otf-droid-nerd perl-app-cpanminus golangci-lint cosmic cosmic-session golangci-lint perlnavigator
		cpan Perl::LanguageServer
		trap 'echo for virtual machines: sudo pacman -S qemu-full' EXIT

    elif [[ "$ID" == "fedora" ]]; then
    	echo "Fedora setup..."
    	sleep 3
        sudo dnf -y install helix akmod-nvidia perltidy xorg-x11-drv-nvidia-cuda ninja-build cmake gcc make gettext curl glibc-gconv-extra openssl-devel perl-FindBin perl-IPC-Cmd perl-File-Compare perl-File-Copy perl perl-devel perl-AnyEvent-AIO perl-Coro perl-JSON perl-Moose perl-PadWalker perl-Scalar-List-Utils perl-App-cpanminus python3-pip alacarte nodejs-bash-language-server
        sudo cpanm Perl::LanguageServer
        cargo install zellij cargo-update 
        # git clone --depth=1 --branch=main --recursive https://github.com/wezterm/wezterm.git
        # cd wezterm
        # ./get-deps
        # cargo build --release
	else
    	echo "Debian setup..."
    	sleep 3
		sudo apt install python3-pip fzf libclang-common-12-dev llvm-12 llvm-12-dev libssl-dev build-essential libreadline-dev unzip

		mkdir -p "$HOME/.local/share/fonts"
		cd ~/.local/share/fonts
		sudo curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
		sudo apt install 
		cd code
	fi
fi
hx -g fetch && hx -g build
bash "$HOME/.update.sh"

echo "setting up neovim"
sleep 3
git clone https://github.com/neovim/neovim.git
cd neovim
# git checkout release-0.12
make CMAKE_BUILD_TYPE=Release
sudo make install
cd

echo "setting up golang"
sleep 3
# install and set up go for development
curl https://ops.city/get.sh -sSfL | sh
go install golang.org/x/tools/gopls@latest
go install github.com/nametake/golangci-lint-langserver@latest
go install github.com/go-delve/delve/cmd/dlv@latest

echo "Don't forget the following steps for git!"
echo 'ssh-keygen -t ed25519 -C "<useremail>"'
echo 'eval "$(ssh-agent -s)"'
echo 'ssh-add ~/.ssh/id_ed25519'
echo 'cat ~/.ssh/id_ed25519.pub'
echo 'git config --global user.name "<username>"'
echo 'git config --global user.email "<useremail>"'
