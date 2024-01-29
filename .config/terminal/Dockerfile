FROM ubuntu:latest

RUN apt-get update && apt-get install -y git curl bash sudo
RUN useradd -ms /bin/bash df-user && echo "df-user:password" | chpasswd && adduser df-user sudo

USER df-user
WORKDIR /home/df-user

RUN curl -s -L https://raw.githubusercontent.com/kryptn/dotfiles/main/.bin/install-dotfiles.sh | bash
