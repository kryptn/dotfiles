
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
alias kc=kubectl
alias doco='docker compose'

alias maelstrom='/Users/david/git/github.com/jepsen-io/maelstrom/release/maelstrom/maelstrom'

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


function gsc() {
  rd="$HOME/git/github.com/$1"

  [ ! -d "$rd" ] && git clone "git@github.com:$1" "$rd"
  cd "$rd"
}

function git-rb() {
  default_branch=`git remote show origin | awk '/HEAD branch/ {print $NF}'`
  this_branch=`git branch --show-current`
  git checkout $default_branch
  git pull
  git branch -D $this_branch
  git checkout -b $this_branch
}

function ssm() {
  aws ssm get-parameters --name $1 | jq '.Parameters[0].Value'
}
