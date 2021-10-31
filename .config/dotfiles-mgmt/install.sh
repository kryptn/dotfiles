alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
echo ".cfg" >> .gitignore

git clone --bare https://github.com/kryptn/dotfiles.git $HOME/.cfg

config checkout
config config status.showUntrackedFiles no