

# nim
# export PATH=/home/david/.nimble/bin:$PATH

# golang
export PATH=$PATH:/usr/local/go/bin:/home/david/go/bin

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

# set python breakpoint tool
export PYTHONBREAKPOINT="pudb.set_trace"

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# haskell
# [ -f "/home/david/.ghcup/env" ] && source "/home/david/.ghcup/env" # ghcup-env
