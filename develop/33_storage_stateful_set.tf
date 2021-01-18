module "storage" {
  depends_on    = [kubernetes_storage_class.volumes]
  source        = "../modules/stateful-set"
  name          = "storage"
  image         = "minio/minio"
  image_version = "RELEASE.2020-11-25T22-36-25Z"
  internal_tcp  = [9000]
  external_tcp  = [9000]
  replicas      = 4
  storage       = "1Gi"
  args = [
    "server",
    "http://storage-0.storage.default.svc.cluster.local/data",
    "http://storage-1.storage.default.svc.cluster.local/data",
    "http://storage-2.storage.default.svc.cluster.local/data",
    "http://storage-3.storage.default.svc.cluster.local/data"
  ]
  mounts = [
    {
      claim_name     = "storage"
      sub_path       = ""
      container_path = "/data"
    }
  ]
  env = {
    MINIO_ACCESS_KEY = var.storage-access-key
    MINIO_SECRET_KEY = random_password.storage.result
  }
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
