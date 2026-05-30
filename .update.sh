#!/usr/bin/env bash

set -e
# set -x

[ "$(command -v python3)" ] && python3 -m venv myenv && source "$HOME/myenv/bin/activate" && python3 -m pip install --upgrade pip
[ "$(command -v python)" ] && python -m venv myenv && source "$HOME/myenv/bin/activate" && python -m pip install --upgrade pip

if [ -f "/etc/os-release" ]; then
   . /etc/os-release
   if [ "$ID_LIKE" == "arch" ]; then
      sudo pacman -Syu
   elif [[ "$ID" == "fedora" ]]; then
      sudo dnf upgrade -y
   elif [[ "$ID_LIKE" == "debian" ]]; then
      sudo apt update && sudo apt upgrade -y
      cargo install-update -a
  fi
fi

rustup update
