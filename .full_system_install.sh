# This script is an install of most of the things I use on a daily for work.
set -e
# install copyq
sudo apt update
sudo apt upgrade -y
sudo add-apt-repository ppa:hluk/copyq
sudo apt update
# basic stuff I will need to get things rolling
sudo apt install zsh tmux fd-find ripgrep vim-gtk3 ninja-build gettext libtool libtool-bin autoconf automake cmake g++ python3-pip pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev unzip curl doxygen gnome-tweaks copyq
cd 
# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source .profile
rustup component add rust-src
rustup toolchain install nightly
rustup default stable
cargo install stylua cargo-update
# get python ready for development
pip install --upgrade pip
pip install pynvim cmake prettier
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
# install alacritty
git clone https://github.com/alacritty/alacritty.git
cd alacritty
cargo build --release
sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
infocmp alacritty
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
sudo update-alternatives --config x-terminal-emulator
gsettings set org.gnome.desktop.default-applications.terminal exec alacritty
gsettings set org.gnome.desktop.default-applications.terminal exec-arg ''
cd 
# install neovim
git clone https://github.com/neovim/neovim.git
cd neovim
export PATH="$HOME/neovim/bin:$PATH"
make CMAKE_BUILD_TYPE=Release
make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/neovim"
sudo make install
cd
sudo apt update
sudo apt install libssl-dev build-essential libreadline-dev unzip
bash update.sh
cd
# install lua
curl -R -O http://www.lua.org/ftp/lua-5.4.4.tar.gz
tar -zxf lua-5.4.4.tar.gz
cd lua-5.4.4
make linux test
sudo make install
cd
# install luarocks
wget https://luarocks.org/releases/luarocks-3.9.1.tar.gz
tar -zxpf luarocks-3.9.1.tar.gz
cd luarocks-3.9.1
./configure --with-lua-include=/usr/local/include
make
sudo make install
cd
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo 'export PATH="$HOME/neovim/bin:$PATH"' >> .bashrc
echo 'export PATH="$HOME/neovim/bin:$PATH"' >> .zshrc
source .profile
source .zshrc
echo "Don't forget the following steps for git!"
echo 'ssh-keygen -t ed25519 -C "<useremail>"'
echo 'eval "$(ssh-agent -s)"'
echo 'ssh-add ~/.ssh/id_ed25519'
echo 'cat ~/.ssh/id_ed25519.pub'
echo 'git config --global user.name "<username>"'
echo 'git config --global user.email "<useremail>"'
