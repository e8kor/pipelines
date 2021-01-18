resource "kubernetes_storage_class" "volumes" {
  metadata {
    name = "volumes"

    annotations = {
      "storageclass.kubernetes.io/is-default-class" = "true"
    }
  }
  storage_provisioner = "kubernetes.io/glusterfs"
  reclaim_policy      = "Delete"
  parameters = {
    endpoint    = "volumes-endpoints"
    resturl     = "http://192.168.0.211:9080"
    restuser    = "admin"
    secretNamespace = "default"
    secretName = "volumes-secret"
    volumetype  = "replicate:1"
    gidMin = "40000"
    gidMax = "50000"
  }
}