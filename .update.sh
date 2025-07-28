#!/bin/bash

set -e
# set -x

python3 -m pip install --upgrade pip
sudo apt update
sudo apt upgrade -y
# flatpak update -y --noninteractive

rustup update
cargo install-update -a
