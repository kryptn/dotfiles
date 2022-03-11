#! /usr/bin/env bash

export GVM_NO_UPDATE_PROFILE="true"

# install gvm
curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash

# bootstrap
sudo apt-get install curl git mercurial make binutils bison gcc build-essential
source $HOME/.gvm/scripts/gvm
gvm install go1.4 -B
source $HOME/.gvm/scripts/gvm
gvm use go1.4
export GOROOT_BOOTSTRAP=$GOROOT

# install latest go
gvm install go1.17.8
gvm use go1.17.8 --default
