#!/usr/bin/env bash

set -e
# set -x

# [ "$(command -v python3)" ] && python3 -m venv myenv && source "$HOME/myenv/bin/activate" && python3 -m pip install --upgrade pip
# [ "$(command -v python)" ] && python -m venv myenv && source "$HOME/myenv/bin/activate" && python -m pip install --upgrade pip
[ "$(command -v flatpak)" ] && flatpak update -y

if [ -f "/etc/os-release" ]; then
   . /etc/os-release
   if [ "$ID_LIKE" == "arch" ]; then
      sudo pacman -Syu
   elif [[ "$ID" == "fedora" ]]; then
      sudo dnf upgrade -y
   elif [[ "$ID_LIKE" == "debian" ]]; then
      sudo apt update && sudo apt upgrade -y
  fi
fi

cargo install-update -a
echo "Updating Helix"
sleep 3
mkdir -p ~/.config/helix/runtime && curl -sL https://github.com/helix-editor/helix/archive/refs/heads/master.tar.gz | tar -xzf - -C ~/.config/helix/runtime --strip-components=2 "*/runtime
/"
cargo install --git https://github.com/helix-editor/helix --bins helix-term --locked
