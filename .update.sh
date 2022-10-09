#!/bin/bash

set -e
set -x

config pull

python3 -m pip install --upgrade pip
sudo apt update
sudo apt dist-upgrade -y

rustup update
cargo install-update -a

