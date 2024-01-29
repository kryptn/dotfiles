

# nim
# export PATH=/home/david/.nimble/bin:$PATH

# direnv

# if command -v /opt/homebrew/bin/direnv &> /dev/null
# then
#     eval "$(direnv hook zsh)"
# fi

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
# could be here too, shouldn't collide
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# haskell
# [ -f "/home/david/.ghcup/env" ] && source "/home/david/.ghcup/env" # ghcup-env


# kube contexts
export KUBECONFIG=""
for file in ~/.kube/*.yaml
do
  export KUBECONFIG=$KUBECONFIG:$file
done


# gvm
[[ -s "/home/david/.gvm/scripts/gvm" ]] && source "/home/david/.gvm/scripts/gvm"

# work specific
[ -s "$HOME/.config/terminal/work.sh" ] && \. "$HOME/.config/terminal/work.sh"

# extra scripts
export PATH="$HOME/.bin:/home/david/.local/bin:$PATH"
