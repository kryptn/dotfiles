function mkenv() {
    pyenv virtualenv $(pyenv global) $1
    pyenv local $1
}


# wsl 2
alias pbpaste="powershell.exe -command \"Get-Clipboard\""
alias pbcopy="clip.exe"


alias reload="source ~/.zshrc"

alias tf="terraform"

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'