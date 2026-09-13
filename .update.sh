#!/usr/bin/env bash

set -e

# uv self update
uv tool upgrade --all

[ "$(command -v flatpak)" ] && flatpak update -y

if [ -f "/etc/os-release" ]; then
   . /etc/os-release
   if [ "$ID_LIKE" == "arch" ]; then
      sudo pacman -Syu
   elif [[ "$ID" == "fedora" ]]; then
      sudo dnf upgrade -y
   else
      sudo apt update && sudo apt upgrade -y
  fi
fi

rustup update
cargo install-update -a
echo "Updating Helix"
sleep 3
mkdir -p ~/.config/helix/runtime && curl -sL https://github.com/helix-editor/helix/archive/refs/heads/master.tar.gz | tar -xzf - -C ~/.config/helix/runtime --strip-components=2 --wildcards '*/runtime'
cargo install --git https://github.com/helix-editor/helix --bins helix-term --locked
