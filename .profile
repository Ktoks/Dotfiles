# ~/.profile
# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

[ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"

[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
