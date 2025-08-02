if [ -f "/etc/os-release" ]; then
  . /etc/os-release
  if [ "$ID" == "arch" ]; then
    sudo pacman -Syu
  else # assumed debian-based
    sudo apt update
    sudo apt upgrade -y
  fi
fi
printf ".cfg\n" >> .gitignore
git clone --bare git@github.com:Ktoks/Dotfiles.git "$HOME/.cfg"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
config checkout

