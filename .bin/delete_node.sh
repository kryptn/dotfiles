#!/usr/bin/env bash

# drain will cordon a node and then evict all pods.
# if the initial command times out, then this will delete
# every pod on that node, which should complete the drain.
#
# use with pueue
# cat nodes.txt | xargs -n1 pueue add $HOME/.bin/delete_node.sh

kubectl drain $1 --delete-emptydir-data --ignore-daemonsets --force --timeout 60s
if [ $? -eq 1 ]; then
    kubectl get pods --all-namespaces --field-selector spec.nodeName=$1 -oyaml | kubectl delete -f -
fi