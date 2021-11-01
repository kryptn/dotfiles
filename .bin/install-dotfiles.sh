git clone --bare https://github.com/kryptn/dotfiles.git $HOME/.cfg

git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout
git --git-dir=$HOME/.cfg/ --work-tree=$HOME config status.showUntrackedFiles no