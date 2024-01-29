
export ZSH=".config/oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -- --unattended --keep-zshrc
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

