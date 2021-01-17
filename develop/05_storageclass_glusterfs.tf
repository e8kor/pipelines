resource "kubernetes_storage_class" "volumes" {
  metadata {
    name = "volumes"

    annotations = {
      "storageclass.kubernetes.io/is-default-class" = "true"
    }
  }
  storage_provisioner = "kubernetes.io/glusterfs"
  reclaim_policy      = "Retain"
  parameters = {
    endpoint    = "volumes-endpoints"
    resturl     = "http://192.168.0.211:9080"
    restuser    = "admin"
    restuserkey = "AdminPass"
  }
}