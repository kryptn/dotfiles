#!/usr/bin/env bash

function pull_secret {
    pull=false

    if [[ -z $2 ]]; then
        read -p "$2 exists, overwrite?" -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
}

function pull_secrets {
    # normalize item or list, then encode each config so it can be iterated over
    config=$(jq -rc '[[.] | flatten | .[] | @base64] | @sh' $1 | tr -d "'")

    for item in $config; do
        _jq() {
            echo $item | base64 --decode | jq -r ${1}
        }
        filename="$(dirname $1)/$(_jq '.filename')"
        param=$(_jq '.parameter')
        pull_secret "$param" "$filename"
    done
}

for ssmfile in $(git --git-dir=$HOME/.cfg/ --work-tree=$HOME ls-files $HOME | grep 'ssm\.json'); do
    pull_secrets $ssmfile
done