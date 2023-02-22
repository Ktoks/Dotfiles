sudo apt update
sudo apt upgrade -y
echo 'ssh-keygen -t ed25519 -C "your email"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
git clone --bare git@github.com:Ktoks/Dotfiles.git $HOME/.cfg
config checkout
echo ".cfg" >> .gitignore
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
config config --local status.showUntrackedFiles no' >> $HOME/.install.sh

