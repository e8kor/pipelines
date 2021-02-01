variable "storage-access-key" {
  type    = string
  default = "minio"
}

resource "random_password" "storage" {
  length           = 16
  special          = true
  override_special = "_%@"
}

output "storage-access-key" {
  value = var.storage-access-key
}

output "storage-secret-key" {
  value     = random_password.storage.result
  sensitive = true
}

resource "kubernetes_service" "external-storage" {
  depends_on = [module.storage]
  metadata {
    name = "external-storage"
    labels = {
      app      = "storage"
      resource = "service"
    }
  }
  spec {
    type = "NodePort"
    port {
      port        = 9000
      target_port = 9000
      node_port   = 30000
    }
    selector = {
      app = "storage"
    }
  }
}
