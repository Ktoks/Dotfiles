#!/bin/bash

set -e
set -x

python3 -m pip install --upgrade pip
sudo apt update
sudo apt dist-upgrade -y

rustup update
cargo install-update -a

