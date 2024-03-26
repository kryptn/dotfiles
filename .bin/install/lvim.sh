#!/bin/bash

python3_latest=`pyenv install --list | grep -v - | grep -v b | grep -v a | tail -1`

version=`pyenv global`
pyenv virtualenv $version neovim3

pyenv activate neovim3

LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
