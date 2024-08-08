# This script is an install of most of the things I use on a daily for work.
source ~/.profile
rustup component add rust-src
rustup toolchain install nightly
rustup default stable
cargo install stylua cargo-update
# get python ready for development
pip install --upgrade pip
pip install pynvim cmake prettier pysqlite3
# get fonts installed for alacritty and neovim
sudo mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
sudo curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
sudo apt install 
cd 
# install node version manager
curl -sL https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh -o install_nvm.sh
bash install_nvm.sh
source .profile
command -v nvm
# install node
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash
sudo apt-get install -y nodejs
npm install -g prettier
npm install -g neovim
npm install -g tree-sitter
# install neovim
mkdir Code
cd Code
git clone https://github.com/neovim/neovim.git
cd neovim
export PATH="$HOME/neovim/bin:$PATH"
git checkout release-0.9
make CMAKE_BUILD_TYPE=Release
make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/neovim"
sudo make install
cd ~/Code
git clone https://github.com/LunarVim/nvim-basic-ide.git ~/.config/nvim

sudo apt update
sudo apt install libclang-common-12-dev llvm-12 llvm-12-dev libssl-dev build-essential libreadline-dev unzip
bash update.sh
cd ~/Code
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo 'export PATH="$HOME/Code/neovim/bin:$PATH"' >> .bashrc
echo 'export PATH="$HOME/Code/neovim/bin:$PATH"' >> .zshrc
source .profile
source .zshrc
echo "Don't forget the following steps for git!"
echo 'ssh-keygen -t ed25519 -C "<useremail>"'
echo 'eval "$(ssh-agent -s)"'
echo 'ssh-add ~/.ssh/id_ed25519'
echo 'cat ~/.ssh/id_ed25519.pub'
echo 'git config --global user.name "<username>"'
echo 'git config --global user.email "<useremail>"'
