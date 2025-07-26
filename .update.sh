#!/bin/bash

set -e
# set -x

update_bins="$1";

# get date to name the bin directory appropriately
date=$(date "+%d-%m-%Y");
mkdir -p ~/Downloads/bins_"${date}";

python3 -m pip install --upgrade pip
sudo apt update
sudo apt dist-upgrade -y
# flatpak update -y --noninteractive

rustup update
cargo install-update -a

printf "new cpu targets can be found by using: rustc --print=target-cpus\n\n"
