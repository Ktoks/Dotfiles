# ~/.profile
# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

source "$HOME/.cargo/env"

if [ -f "$HOME/.bashrc" ]; then
  source "$HOME/.bashrc"
fi


# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

