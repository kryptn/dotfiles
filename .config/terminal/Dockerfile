FROM bitnami/kubectl:1.20.9 as kubectl



FROM ubuntu:latest

RUN apt-get update && apt-get install -y apt-transport-https ca-certificates \
    curl bash sudo zsh git unzip



RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf aws awscliv2.zip

RUN useradd -ms /bin/zsh df-user && echo "df-user:password" | chpasswd && adduser df-user sudo

COPY --from=kubectl /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/

USER df-user
WORKDIR /home/df-user

RUN curl -s -L https://raw.githubusercontent.com/kryptn/dotfiles/main/.bin/install-dotfiles.sh | zsh
RUN ./.bin/install/zsh.sh && zsh
