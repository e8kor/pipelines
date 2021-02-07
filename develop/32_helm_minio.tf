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

resource "helm_release" "storage" {
  depends_on = [kubernetes_namespace.storage]
  name       = "storage"
  repository = "https://helm.min.io/"
  chart      = "minio"
  version    = "8.0.9"
  namespace  = "storage"

  set {
    name  = "accessKey"
    value = var.storage-access-key
  }
  set {
    name  = "secretKey"
    value = random_password.storage.result
  }
  set {
    name  = "persistence.storageClass"
    value = "openebs-sc-statefulset"
  }
  set {
    name  = "persistence.size"
    value = "30Gi"
  }
  values = [
    file("${path.module}/helm_minio/values.yaml")
  ]
}
