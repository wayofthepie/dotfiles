# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
# Fix key mappings on the apple keyboard
# to reset :
# gsettings reset org.gnome.desktop.input-sources xkb-options
#gsettings set org.gnome.desktop.input-sources xkb-options "['apple:badmap']"
#go112 () {
#  /home/chaospie/.gvm/bin/gvm use go1.12 > /dev/null
#  export GOPATH=$HOME/go 
#}
#go112

# For xmonad so it will revert to a black screen
# when all windows are closed
xsetroot -solid black

export PATH="$HOME/.cargo/bin:$PATH:$GOPATH/bin"
export PATH="/home/chaospie/.local/bin:~/.local/:$PATH"
if [ -e /home/chaospie/.nix-profile/etc/profile.d/nix.sh ]; then . /home/chaospie/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
