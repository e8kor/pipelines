resource "kubernetes_persistent_volume" "storage" {
  metadata {
    name = "storage"
  }
  spec {
    capacity = {
      storage = "2Gi"
    }
    storage_class_name = "standard"
    access_modes = ["ReadWriteMany"]
    persistent_volume_reclaim_policy = "Retain"
    persistent_volume_source {
      host_path {
        path = "/mnt/storage"
      }
    }
  }
}
