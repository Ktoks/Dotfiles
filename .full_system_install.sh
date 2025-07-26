# This script is an install of most of the things I use on a daily for work.

set -e

printf "setting up rust"
sleep 3
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.profile
rustup component add rust-src
rustup toolchain install nightly
rustup default stable
cargo install cargo-binstall cargo-update

printf "installing rust-based essentials"
sleep 1
cargo-binstall du-dust fd-find ripgrep sd shellharden stylua zellij

printf "setting up python"
sleep 3
sudo apt install python3.12 python3-pip
python3 -m pip install --upgrade pip
python3 -m pip install pynvim cmake prettier pysqlite3

printf "setting up fonts"
sleep 3
sudo mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
sudo curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
sudo apt install 
cd 

# printf "setting up nvm"
# sleep 3
# curl -sL https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh -o install_nvm.sh
# bash install_nvm.sh
# source .profile
# command -v nvm

# printf "setting up node"
# curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash
# sudo apt-get install -y nodejs

# printf "getting essentials from npm"
# sleep 3
# npm install -g prettier
# npm install -g neovim
# npm install -g tree-sitter

printf "setting up development environment"
sleep 1
mkdir code
cd code

printf "setting up neovim"
sleep 3
git clone https://github.com/neovim/neovim.git
cd neovim
export PATH="$HOME/neovim/bin:$PATH"
git checkout release-0.12
sudo apt update
sudo apt install libclang-common-12-dev llvm-12 llvm-12-dev libssl-dev build-essential libreadline-dev unzip
make CMAKE_BUILD_TYPE=Release
make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/neovim"
sudo make install
cd ~/code

printf "installing other tools"
sudo apt install duf lshw fzf ffmpeg 7zip jq fzf
# cargo install --locked yazi-fm yazi-cli

printf "running update script"
sleep 1
bash update.sh

printf "Don't forget the following steps for git!"
printf 'ssh-keygen -t ed25519 -C "<useremail>"'
printf 'eval "$(ssh-agent -s)"'
printf 'ssh-add ~/.ssh/id_ed25519'
printf 'cat ~/.ssh/id_ed25519.pub'
printf 'git config --global user.name "<username>"'
printf 'git config --global user.email "<useremail>"'
