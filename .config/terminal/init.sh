if command -v /usr/bin/keychain &> /dev/null
then
    # wsl 2 keychain
    export HOSTNAME="DESKTOP-F98TO1V"
    /usr/bin/keychain --nogui $HOME/.ssh/github
    source $HOME/.keychain/$HOSTNAME-sh
fi