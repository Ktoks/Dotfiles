# This script is an install of most of the things I use on a daily for work.

set -e

echo "setting up rust"
sleep 3
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.profile
rustup component add rust-src
rustup toolchain install nightly
rustup default stable
cargo install cargo-binstall cargo-update

echo "installing rust-based essentials"
sleep 1
cargo-binstall bat bottom cross du-dust eza fd-find hyperfine monolith procs ripgrep rnr rust-parallel rustscan sd shellharden starship stylua trippy zellij

echo "setting up python"
sleep 3
pip install --upgrade pip
pip install pynvim cmake prettier pysqlite3

echo "setting up fonts"
sleep 3
sudo mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
sudo curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
sudo apt install 
cd 

echo "setting up nvm"
sleep 3
curl -sL https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh -o install_nvm.sh
bash install_nvm.sh
source .profile
command -v nvm

# echo "setting up node"
# curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash
# sudo apt-get install -y nodejs

echo "getting essentials from npm"
sleep 3
npm install -g prettier
npm install -g neovim
npm install -g tree-sitter

echo "setting up development environment"
sleep 1
mkdir code
cd code

echo "setting up neovim"
sleep 3
git clone https://github.com/neovim/neovim.git
cd neovim
export PATH="$HOME/neovim/bin:$PATH"
git checkout release-0.11
sudo apt update
sudo apt install libclang-common-12-dev llvm-12 llvm-12-dev libssl-dev build-essential libreadline-dev unzip
make CMAKE_BUILD_TYPE=Release
make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/neovim"
sudo make install
cd ~/code

echo "installing other tools"
sudo apt install duf mosh lshw fzf ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick
cargo install --locked yazi-fm yazi-cli

echo "installing go tools"
sleep 3
go install github.com/mr-karan/doggo/cmd/doggo@latest
go install github.com/gcla/termshark/v2/cmd/termshark@latest
go install github.com/schollz/croc/v10@latest

echo "running update script"
sleep 1
bash update.sh

echo "Don't forget the following steps for git!"
echo 'ssh-keygen -t ed25519 -C "<useremail>"'
echo 'eval "$(ssh-agent -s)"'
echo 'ssh-add ~/.ssh/id_ed25519'
echo 'cat ~/.ssh/id_ed25519.pub'
echo 'git config --global user.name "<username>"'
echo 'git config --global user.email "<useremail>"'
