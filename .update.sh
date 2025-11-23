#!/usr/bin/env bash

set -e
# set -x

if [ "$(command -v python3)" ]; then
   python3 -m venv myenv && source "$HOME/myenv/bin/activate" && python3 -m pip install --upgrade pip
elif [ "$(command -v python)" ]; then
   python -m venv myenv && source "$HOME/myenv/bin/activate" && python -m pip install --upgrade pip
fi

if [ -f "/etc/os-release" ]; then
   . /etc/os-release
   if [ "$ID_LIKE" == "arch" ]; then
      sudo pacman -Syu
   elif [[ "$ID" == "fedora" ]]; then
      sudo dnf upgrade -y
      cargo install-update -a
   elif [[ "$ID_LIKE" == "debian" ]]; then
      sudo apt update && sudo apt upgrade -y
      cargo install-update -a
  fi
fi

rustup update
