# Homebrew Ingestion Pipelines

Project is attempt to setup home lab data ingestion using raspberry pi 2/3/4.
Its recommended to make raspberry 4 as master node.

To setup cluster used terraform + shell

Run initilize_cluster.sh to initlize cluster with utilities

Script breakdown:

Install arkade:
```bash 
    curl -sSL https://dl.get-arkade.dev | sudo sh
```

Install k3sup:
```bash
    arkade get k3sup
```

Create cluster:
```bash 
k3sup install --ip $master --user pi  \
    && k3sup join --ip $node1 --server-ip $master --user pi \
    && k3sup join --ip $node2 --server-ip $master --user pi \
    && k3sup join --ip $node3 --server-ip $master --user pi
```

Install OpenFaas, its connectors, and Dashboard:
```bash
arkade install openfaas \
    && arkade install kubernetes-dashboard  \
    && arkade install cron-connector \
    && arkade install nats-connector
```

TODO:
- airflow integration