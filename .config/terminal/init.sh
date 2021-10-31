
export HOSTNAME="DESKTOP-F98TO1V"

# wsl 2 keychain
/usr/bin/keychain --nogui $HOME/.ssh/github
source $HOME/.keychain/$HOSTNAME-sh

