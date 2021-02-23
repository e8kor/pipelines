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

resource "kubernetes_namespace" "storage" {
  metadata {
    labels = {
      app      = "storage"
      resource = "namespace"
    }

    name = "storage"
  }
}

resource "helm_release" "storage" {
  depends_on = [helm_release.openebs]
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
    value = "openebs-jiva-default"
  }
  set {
    name  = "resources.requests.memory"
    value = "2Gi"
  }
  set {
    name  = "persistence.size"
    value = "30Gi"
  }
  set {
    name  = "serviceAccount.name"
    value = "storage"
  }
  set {
    name  = "mcImage.tag"
    value = "RELEASE.2020-11-25T22-36-25Z"
  }
  set {
    name  = "replicas"
    value = 2
  }
  set {
    name  = "image.tag"
    value = "RELEASE.2020-11-25T22-36-25Z"
  }
  values = [
    file("${path.module}/helm_minio/values.yaml")
  ]
}


resource "kubernetes_service" "external-storage" {
  depends_on = [helm_release.openebs]
  metadata {
    name      = "external-storage"
    namespace = "storage"
    labels = {
      app      = "external-storage"
      resource = "service"
    }
  }

  spec {
    type = "NodePort"
    port {
      port        = 9000
      target_port = 9000
      node_port   = 32000
    }
    selector = {
      app = "minio"
    }
  }
}