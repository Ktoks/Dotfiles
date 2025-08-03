#!/usr/bin/env bash
# This script is an install of most of the things I use on a daily for work.

set -ex

echo "setting up basic development stuffs"
sleep 3
if [ -f "/etc/os-release" ]; then
	. /etc/os-release
	if [ "$ID_LIKE" == "arch" ]; then
		sudo pacman -S --needed python-pip wezterm ripgrep fd dust stylua zellij perl-test-perltidy shellcheck ruff-lsp bash-language-server helix fzf base-devel cmake ninja curl otf-droid-nerd
	else # assumed debian-based
		sudo apt install python3-pip fzf libclang-common-12-dev llvm-12 llvm-12-dev libssl-dev build-essential libreadline-dev unzip

		mkdir -p "$HOME/.local/share/fonts"
		cd ~/.local/share/fonts
		sudo curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
		sudo apt install 
	fi
fi
cd "$HOME"
mkdir code
cd code

echo "setting up neovim"
sleep 3
git clone https://github.com/neovim/neovim.git
cd neovim
# git checkout release-0.12
make CMAKE_BUILD_TYPE=Release
sudo make install
cd ~/code

echo "setting up rust"
sleep 3
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.profile"

bash "$HOME/.update.sh"

echo "Don't forget the following steps for git!"
echo 'ssh-keygen -t ed25519 -C "<useremail>"'
echo 'eval "$(ssh-agent -s)"'
echo 'ssh-add ~/.ssh/id_ed25519'
echo 'cat ~/.ssh/id_ed25519.pub'
echo 'git config --global user.name "<username>"'
echo 'git config --global user.email "<useremail>"'
