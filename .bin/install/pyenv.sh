#! /usr/bin/env bash

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

version=`pyenv install --list | grep -v - | grep -v b | grep -v a | tail -1`
pyenv install $version
pyenv --global $version

