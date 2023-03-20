#!/bin/bash

set -e
set -x

python3 -m pip install --upgrade pip
sudo apt update
sudo apt dist-upgrade -y
flatpak update -y --noninteractive

rustup update
cargo install-update -a

echo "I'm about to update Helix - stop me if you aren't ready"

sleep 5

cd ~/Code/helix/
git pull
cargo install --locked --path helix-term

echo "I\'m about to update Neovim - stop me if you aren\'t ready"

sleep 5

cd ~/Code/neovim/
git pull
rm -rf build/
make CMAKE_BUILD_TYPE=Release
sudo make install
