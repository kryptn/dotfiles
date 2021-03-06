
#update and install what we need
sudo apt update
sudo apt -y upgrade
sudo apt install -y tmux git vim zsh curl

#install pip and npm
curl -sSL https://bootstrap.pypa.io/get-pip.py | sudo python3
curl -sSL https://deb.nodesource.com/setup_7.x | sudo -E bash -
sudo apt install -y nodejs

# install vim  dependencies
sudo pip install flake8 jedi

# link dotfiles
cd ~
git clone https://github.com/kryptn/dotfiles .dotfiles
ln -s .dotfiles/.vim .vim
ln -s .dotfiles/.vimrc .vimrc
ln -s .dotfiles/.tmux.conf .tmux.conf

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
rm .zshrc
ln -s .dotfiles/.zshrc .zshrc
# shell change attempt will fail, so force it
sudo chsh -s $(which zsh) $USER
