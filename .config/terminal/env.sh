

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
    eval "$(pyenv init --path --no-rehash zsh)"
    eval "$(pyenv virtualenv-init - zsh)"
fi

# set python breakpoint tool
export PYTHONBREAKPOINT="pudb.set_trace"

# rust
if command -v $HOME/.cargo/bin/cargo &> /dev/null
then
    export PATH="$HOME/.cargo/bin:$PATH"
    if command -v $HOME/.cargo/bin/sccache &> /dev/null
    then
        export RUSTC_WRAPPER=$HOME/.cargo/bin/sccache
    fi
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

if command -v direnv &> /dev/null 
then
    eval "$(direnv hook zsh)"
fi

# gvm
[[ -s "/home/david/.gvm/scripts/gvm" ]] && source "/home/david/.gvm/scripts/gvm"

# brew
[ -s /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"

# work specific
[ -s "$HOME/.config/terminal/work.sh" ] && \. "$HOME/.config/terminal/work.sh"

# extra scripts
export PATH="$HOME/.bin:$HOME.local/bin:$PATH"

DELTA_PAGER="less -R"

# i can't stand the aws cli pagination output
# why would i want that
export AWS_PAGER=""
