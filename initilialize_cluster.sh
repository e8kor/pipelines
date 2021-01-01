#!/bin/bash

master="192.168.0.211"
node1="192.168.0.212"
node2="192.168.0.213"
node3="192.168.0.214"

if ! [ -x "$(command -v arkade)" ]; then
    echo ' arkade is not installed.'
    curl -sSL https://dl.get-arkade.dev | sudo sh
fi

if ! [ -x "$(command -v k3sup)" ]; then
    echo 'k3sup is not installed.'
    arkade get k3sup
fi

read -p "Initialize cluster? [Y/n]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    k3sup install --ip $master --user pi --local-path ~/.kube/config \
        && k3sup join --ip $node1 --server-ip $master --user pi \
        && k3sup join --ip $node2 --server-ip $master --user pi \
        && k3sup join --ip $node3 --server-ip $master --user pi

    kubectl label node node2.k3s node-role.kubernetes.io/worker= \
    && kubectl label node node3.k3s node-role.kubernetes.io/worker= \
    && kubectl label node node4.k3s node-role.kubernetes.io/worker=
fi

read -p "Should install linkerd2? [Y/n]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo 'start linkerd installation'
    if ! [ -x "$(command -v linkerd2)" ]; then
        echo 'linkerd2 is not installed.'
        arkade get linkerd2
    fi

    echo 'installing linkerd'
    arkade install linkerd

    echo 'installing linkerd-injection'
    kubectl -n openfaas get deploy gateway -o yaml | linkerd inject --skip-outbound-ports=4222 - | kubectl apply -f - \
        && kubectl -n openfaas get deploy/basic-auth-plugin -o yaml | linkerd inject - | kubectl apply -f - \
        && kubectl -n openfaas get deploy/faas-idler -o yaml | linkerd inject - | kubectl apply -f -  \
        && kubectl -n openfaas get deploy/queue-worker -o yaml | linkerd inject  --skip-outbound-ports=4222 - | kubectl apply -f - \
        && kubectl annotate namespace openfaas-fn linkerd.io/inject=enabled  \
        && kubectl -n openfaas-fn get deploy -o yaml | linkerd inject - | kubectl apply -f -
fi