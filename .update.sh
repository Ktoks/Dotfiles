#!/bin/bash

set -e
# set -x

python3 -m pip install --upgrade pip
if [ -f "/etc/os-release" ]; then
  . /etc/os-release
  if [ "$ID" == "arch" ]; then
     sudo pacman -Syu
  else # assumed debian-based
     sudo apt update
     sudo apt upgrade -y
  fi
fi

# rustup update
# cargo install-update -a
