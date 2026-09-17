#!/usr/bin/env bash
# This script is an install of most of the things I use on a daily for work.

set -e

if [ -f "/etc/os-release" ]; then
	. /etc/os-release
	if [ "$ID_LIKE" == "arch" ]; then
		echo "Arch setup..."
		sleep 3
		sudo pacman -S --needed wezterm perl perl-test-perltidy shellcheck ruff-lsp bash-language-server base-devel cmake ninja curl otf-droid-nerd perl-app-cpanminus cosmic cosmic-session perlnavigator
		sudo cpanm Perl::LanguageServer Perl::Critic
		trap 'echo for virtual machines: sudo pacman -S qemu-full' EXIT

	elif [[ "$ID" == "fedora" ]]; then
		echo "Fedora setup..."
		sleep 3
		echo "ip_resolve=4" | sudo tee /etc/dnf/dnf.conf
		sudo dnf copr enable wezfurlong/wezterm-nightly
		sudo curl -o /etc/yum.repos.d/msprod.repo https://packages.microsoft.com/config/rhel/10/prod.repo
		sudo dnf -y install perltidy ninja-build cmake gcc make gettext curl glibc-gconv-extra openssl-devel perl-FindBin perl-IPC-Cmd perl-File-Compare perl-File-Copy perl perl-devel perl-AnyEvent-AIO perl-Coro perl-JSON perl-Moose perl-PadWalker perl-Scalar-List-Utils perl-App-cpanminus python3.14 alacarte nodejs-bash-language-server wezterm vlc vlc-plugin*x86_64 mssql-tools18
		sudo cpanm Perl::LanguageServer Perl::Critic
		sudo npm install -g perlnavigator-server
	else
		echo "Debian setup..."
		sleep 3
		sudo add-apt-repository ppa:deadsnakes/ppa -y
		sudo apt install libssl-dev build-essential unzip software-properties-common shellcheck python3.14 python3.14-venv tmux -y
	fi
fi
# bash "$HOME/.update.sh"

# echo "setting up neovim"
# sleep 3
# mkdir -p "$HOME/code"
# cd "$HOME/code"
# git clone https://github.com/neovim/neovim.git
# cd neovim
# # git checkout release-0.12
# make CMAKE_BUILD_TYPE=Release
# sudo make install
# cd

echo "Install Python uv tool"
sleep 3
curl -LsSf https://astral.sh/uv/install.sh | sh

echo 'Install Go and tools'
sleep 3
mkdir -p $HOME/Downloads
cd $HOME/Downloads
wget https://go.dev/dl/go1.27.0.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.27.0.linux-amd64.tar.gz
rm -f $HOME/Downloads/go1.27.0.linux-amd64.tar.gz
export GOPATH="$HOME/code/go" && export GOBIN="$HOME/code/go/bin" && PATH="$PATH:$GOBIN:$HOME/go/bin/:/usr/local/go/bin/"
go env -w GOAMD64=v3 GOOS=linux GOARCH=amd64 CGO_ENABLED=0 GOFLAGS='-trimpath -ldflags="-s -w"'
=======
go env -w GOAMD64=v3 GOOS=linux GOARCH=amd64 CGO_ENABLED=0
export GOFLAGS='-trimpath "-ldflags=-s -w"'
go install golang.org/x/tools/gopls@latest
go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@latest
go install github.com/nametake/golangci-lint-langserver@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install github.com/junegunn/fzf@latest
 
echo 'Installing rust and tools'
sleep 3
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
PATH="$PATH:$HOME/.cargo/bin" && export RUSTFLAGS="-C target-cpu=native -C codegen-units=1 -C strip=symbols" && export CARGO_PROFILE_RELEASE_LTO=thin
cargo install cargo-update sd ripgrep fd-find bat stylua du-dust

echo "Installing Helix"
sleep 3
mkdir -p ~/.config/helix/runtime && curl -sL https://github.com/helix-editor/helix/archive/refs/heads/master.tar.gz | tar -xzf - -C ~/.config/helix/runtime --strip-components=2 --wildcards '*/runtime'
HELIX_DISABLE_AUTO_GRAMMAR_BUILD=1 cargo install --git https://github.com/helix-editor/helix --bins helix-term --locked
hx -g fetch && hx -g build

echo "To install Lua:"
echo "Go here: https://github.com/LuaLS/lua-language-server/releases"
echo "then run:
# 1. Create a home folder for the language server
mkdir -p ~/.local/share/lua-language-server ~/.local/bin

# 2. Download the latest Linux x64 release from GitHub
curl -L -o luals.tar.gz https://github.com

# 3. Extract it into its home folder
tar -xvzf luals.tar.gz -C ~/.local/share/lua-language-server
rm luals.tar.gz

# 4. Expose the binary to your terminal path via a symlink
ln -sf ~/.local/share/lua-language-server/bin/lua-language-server ~/.local/bin/lua-language-server"
# echo "Don't forget the following steps for git!"
# echo 'ssh-keygen -t ed25519 -C "<useremail>"'
# echo 'eval "$(ssh-agent -s)"'
# echo 'ssh-add ~/.ssh/id_ed25519'
# echo 'cat ~/.ssh/id_ed25519.pub'
# echo 'git config --global user.name "<username>"'
# echo 'git config --global user.email "<useremail>"'
echo "if running Ubuntu-like:
sudo systemctl disable --now \
  snapd.service \
  snapd.apparmor.service \
  snapd.autoimport.service \
  snapd.core-fixup.service \
  snapd.recovery-chooser-trigger.service \
  snapd.seeded.service \
  snapd.system-shutdown.service \
  snap.cups.cups-browsed.service \
  snap.cups.cupsd.service \
  wpa_supplicant.service \
  ModemManager.service \
  cups.service \
  cups-browsed.service \
  apport.service \
  rsyslog.service \
  ubuntu-advantage.service \
  ua-reboot-cmds.service \
  switcheroo-control.service \
  NetworkManager-wait-online.service
Then:
sudo systemctl mask --now cups.service cups.socket cups.path snapd.service snapd.socket
sudo systemctl disable --now apt-daily.timer apt-daily-upgrade.timer
sudo systemctl mask --now apt-daily.timer apt-daily-upgrade.timer
sudo apt purge pop-transition
sudo systemctl disable --now com.system76.SystemUpdater.service
sudo systemctl mask --now com.system76.SystemUpdater.service
mkdir -p ~/.config/autostart
cp /etc/xdg/autostart/io.elementary.appcenter-daemon.desktop ~/.config/autostart/
echo "X-GNOME-Autostart-enabled=false" >> ~/.config/autostart/io.elementary.appcenter-daemon.desktop

# For desktop machine with massive memory add this to /etc/sysctl.d/99-custom-performance.conf:
# Keep active data in physical RAM; swap only under extreme emergency
vm.swappiness = 1

# Maximize filesystem metadata (dentry/inode) retention in 94GB RAM
vm.vfs_cache_pressure = 10

# Disable percentage-based dirty ratios (set to 0 to enable byte limits)
vm.dirty_ratio = 0
vm.dirty_background_ratio = 0

# Start background NVMe writes as soon as 64 MB of dirty data accumulates
vm.dirty_background_bytes = 67108864

# Block process I/O only if unwritten dirty data reaches 256 MB
vm.dirty_bytes = 268435456

# Then run sudo sysctl --system

# Turn off zRAM compression:
sudo systemctl disable --now pop-default-settings-zram.service
sudo swapoff -a

# Turn off unnecessary autostart features:
mkdir -p ~/.config/autostart

for file in \
  print-applet.desktop \
  snap-userd-autostart.desktop \
  geoclue-demo-agent.desktop \
  orca-autostart.desktop \
  at-spi-dbus-bus.desktop \
  com.system76.CosmicInitialSetup.desktop \
  im-launch.desktop \
  org.pop_os.transition.Notify.desktop \
  pop-app-folders.desktop \
  pop-flatpak-repos.desktop \
  user-dirs-update-gtk.desktop \
  xdg-user-dirs.desktop; do
    cp /etc/xdg/autostart/"$file" ~/.config/autostart/ 2>/dev/null
    echo "Hidden=true" >> ~/.config/autostart/"$file"
    echo "X-GNOME-Autostart-enabled=false" >> ~/.config/autostart/"$file"
done

echo Then modify the systemd behavior to remove files over 500M, and system files over 100M, then turn off swap by commenting out the line in the 2nd and 3rd files:
sudo hx /etc/systemd/journald.conf /etc/crypttab /etc/fstab

sudo sysctl --system

sudo update-initramfs -u

# then change:

# SystemMaxUse=500M
# SystemMaxFileSize=100M
# Storage=persistent

"
