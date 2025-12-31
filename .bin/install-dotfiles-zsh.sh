#!/bin/bash

git clone --bare https://github.com/kryptn/dotfiles.git "$HOME/.cfg"

git --git-dir="$HOME/.cfg/" --work-tree="$HOME" checkout
git --git-dir="$HOME/.cfg/" --work-tree="$HOME" config status.showUntrackedFiles no

ln -sf "$HOME/.config/terminal/.zshrc" "$HOME/.zshrc"
echo "Created symlink: ~/.zshrc -> ~/.config/terminal/.zshrc"
