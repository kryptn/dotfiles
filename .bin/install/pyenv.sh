#! /usr/bin/env bash

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

sudo apt install build-essential zlib1g zlib1g-dev libssl-dev libbz2-dev libsqlite3-dev libncurses-dev libreadline-dev libffi-dev liblzma-dev


version=`pyenv install --list | grep -v - | grep -v b | grep -v a | tail -1`
pyenv install $version
pyenv --global $version
