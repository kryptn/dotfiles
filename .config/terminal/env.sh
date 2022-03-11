

# nim
# export PATH=/home/david/.nimble/bin:$PATH

# golang

if command -v /usr/local/go/bin/go &> /dev/null
then
    export PATH=$PATH:/usr/local/go/bin:/$HOME/go/bin
fi

# pyenv

if command -v $HOME/.pyenv/bin/pyenv &> /dev/null
then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# set python breakpoint tool
export PYTHONBREAKPOINT="pudb.set_trace"

# rust
if command -v $HOME/.cargo/bin/cargo &> /dev/null
then

    export PATH="$HOME/.cargo/bin:$PATH"
fi


# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# haskell
# [ -f "/home/david/.ghcup/env" ] && source "/home/david/.ghcup/env" # ghcup-env


# kube contexts
export KUBECONFIG=~/.kube/config
for file in ~/.kube/*.yaml
do
  export KUBECONFIG=$KUBECONFIG:$file
done


# gvm
[[ -s "/home/david/.gvm/scripts/gvm" ]] && source "/home/david/.gvm/scripts/gvm"

# work specific
[ -s "$HOME/.config/terminal/work.sh" ] && \. "$HOME/.config/terminal/work.sh"
