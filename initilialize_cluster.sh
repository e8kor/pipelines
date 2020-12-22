#!/bin/bash

master="192.168.0.211"
node1="192.168.0.212"
node2="192.168.0.213"
node3="192.168.0.214"

curl -sSL https://dl.get-arkade.dev | sudo sh

arkade get k3sup

k3sup install --ip $master --user pi && \
    k3sup join --ip $node1 --server-ip $master --user pi && \
    k3sup join --ip $node2 --server-ip $master --user pi && \
    k3sup join --ip $node3 --server-ip $master --user pi


arkade install openfaas && \
    arkade install kubernetes-dashboard


