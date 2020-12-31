#!/bin/bash

master="192.168.0.211"
node1="192.168.0.212"
node2="192.168.0.213"
node3="192.168.0.214"

curl -sSL https://dl.get-arkade.dev | sudo sh

arkade get k3sup

k3sup install --ip $master --user pi  \
    && k3sup join --ip $node1 --server-ip $master --user pi \
    && k3sup join --ip $node2 --server-ip $master --user pi \
    && k3sup join --ip $node3 --server-ip $master --user pi

arkade install openfaas \
    && arkade install kubernetes-dashboard  \
    && arkade install cron-connector \
    && arkade install nats-connector
    && arkade get linkerd2 \
    && arkade install linkerd 

kubectl -n openfaas get deploy gateway -o yaml | linkerd inject --skip-outbound-ports=4222 - | kubectl apply -f - \
    && kubectl -n openfaas get deploy/basic-auth-plugin -o yaml | linkerd inject - | kubectl apply -f - \
    && kubectl -n openfaas get deploy/faas-idler -o yaml | linkerd inject - | kubectl apply -f -  \
    && kubectl -n openfaas get deploy/queue-worker -o yaml | linkerd inject  --skip-outbound-ports=4222 - | kubectl apply -f - \
    && kubectl annotate namespace openfaas-fn linkerd.io/inject=enabled  \
    && kubectl -n openfaas-fn get deploy -o yaml | linkerd inject - | kubectl apply -f -