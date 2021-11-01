
if ! command -v pbpaste &> /dev/null
then
    # wsl 2
    alias pbpaste="powershell.exe -command \"Get-Clipboard\""
    alias pbcopy="clip.exe"
fi


alias reload="source ~/.zshrc"
alias reload-aliases="source ~/.config/terminal/aliases.sh"

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'


alias tf=terraform
alias doco=docker-compose


function mkenv() {
  # creates a new virtualenv and sets it as local for this folder

  version="$(pyenv global)"

  if [ ! -z "$1" ]
    then version=$1
  fi

  env_name=$(basename "$PWD")

  pyenv virtualenv $version $env_name
  pyenv local $env_name
}

function uuid(){
  python -c 'import uuid; print(str(uuid.uuid4()), end="")'
}
