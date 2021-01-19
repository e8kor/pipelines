resource "kubernetes_storage_class" "volumes" {
  metadata {
    name = "volumes"
    annotations = {
      "storageclass.kubernetes.io/is-default-class" = "true"
    }
  }
  storage_provisioner = "kubernetes.io/glusterfs"
  reclaim_policy      = "Retain"
  volume_binding_mode = "Immediate"
  parameters = {
    resturl          = "http://192.168.0.211:9080"
    restuser         = "admin"
    restauthenabled  = "true"
    secretNamespace  = "default"
    secretName       = "volumes-secret"
    volumetype       = "replicate:2"
    clusterid        = "25d9aca0b070d0fb3c9bc8f1069e055b"
    volumenameprefix = ""
  }
}