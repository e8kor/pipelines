resource "kubernetes_storage_class" "fs" {
  metadata {
    name = "fs"
    annotations = {
      "storageclass.kubernetes.io/is-default-class" = "true"
    }
    labels = {
      "resource" = "storageclass"
      "app" = "fs"
    }
  }
  storage_provisioner = "kubernetes.io/glusterfs"
  reclaim_policy      = "Retain"
  volume_binding_mode = "Immediate"
  parameters = {
    endpoints_name = "heketi-storage-endpoints"
    resturl          = "http://fs-provisioner:8080"
    restuser         = "admin"
    secret_namespace = "default"
    secret_name = "fs-config-secret"
  }
}