#  dotfiles

```bash
curl -s -L https://raw.githubusercontent.com/kryptn/dotfiles/main/.bin/install-dotfiles.sh | bash
```

then probably

```bash
./.bin/install/osx.sh
# or
./.bin/install/debian.sh
```

and then:

```
./.bin/install/zsh.sh
./.bin/install/tailscale.sh
./.bin/install/rustup.sh
./.bin/install/cargo-install.sh
```


## test drive with docker

```bash

cd ~/.config/terminal
docker build -t kryptn/dotfiles .
docker run -it kryptn/dotfiles /bin/bash

```
