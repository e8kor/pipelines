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
    && arkade install kubernetes-dashboard
    && arkade get linkerd2 \
    && arkade install linkerd 
```

```bash
kubectl -n openfaas get deploy gateway -o yaml | linkerd inject --skip-outbound-ports=4222 - | kubectl apply -f - \
    && kubectl -n openfaas get deploy/basic-auth-plugin -o yaml | linkerd inject - | kubectl apply -f - \
    && kubectl -n openfaas get deploy/faas-idler -o yaml | linkerd inject - | kubectl apply -f -  \
    && kubectl -n openfaas get deploy/queue-worker -o yaml | linkerd inject  --skip-outbound-ports=4222 - | kubectl apply -f - \
    && kubectl annotate namespace openfaas-fn linkerd.io/inject=enabled  \
    && kubectl -n openfaas-fn get deploy -o yaml | linkerd inject - | kubectl apply -f -
```

TODO:
- airflow integration
- Kubernetes cluster is too weak to handle linkerd2 installed
- add glusterfs as network storage
