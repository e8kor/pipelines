resource "kubernetes_persistent_volume" "storage" {
  metadata {
    name = var.name
    labels = {
      app = var.name
      resource = "volume"
    }
  }
  spec {
    capacity = {
      storage = var.storage
    }
    storage_class_name = "standard"
    access_modes = ["ReadWriteMany"]
    persistent_volume_reclaim_policy = "Retain"
    persistent_volume_source {
      host_path {
        path = var.storage_path
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "storage" {
  metadata {
    name = var.name
    labels = {
      app = var.name
      resource = "volume-claim"
    }
  }
  spec {
    storage_class_name = "standard"
    access_modes       = ["ReadWriteMany"]
    resources {
      requests = {
        storage = var.storage
      }
    }
    volume_name = var.name
  }
}
