# Homebrew Ingestion Pipelines

Project is attempt to setup home lab data ingestion using raspberry pi 2/3/4.
Its recommended to make raspberry 4 as master node.

To setup cluster used terraform + shell

TODO:
- airflow integration
- Kubernetes cluster is too weak to handle linkerd2 installed
- add glusterfs as network storage

fernet key: M336Pq2Y8TlMXIO0hPbmQkvtJEutPUPEc95DAyQl56A=

Tips: 
    run infinite loop for debug: `command = [ "tail", "-F", "/opt/entrypoint.sh"]`