resource "kubernetes_stateful_set" "storage" {
  metadata {
    name = "storage"
  }

  spec {
    service_name = "storage"
    replicas = 4
    selector {
      match_labels = {
        app = "storage"
      }
    }
    template {
      metadata {
        labels = {
          app = "storage"
        }
      }
      spec {
        container {
          name = "storage"
          image = "minio/minio:RELEASE.2020-11-25T22-36-25Z"
          env {
            name = "MINIO_ACCESS_KEY"
            value = var.storage_access_key
          }
          env { 
            name = "MINIO_SECRET_KEY"
            value = random_password.storage.result
          }
          args = [ 
            "server",
            "http://storage-0.storage.default.svc.cluster.local/data",
            "http://storage-1.storage.default.svc.cluster.local/data",
            "http://storage-2.storage.default.svc.cluster.local/data",
            "http://storage-3.storage.default.svc.cluster.local/data" 
          ]
          port {
            container_port = 9000
            host_port = 9000
          }
          volume_mount {
            name = "storage"
            mount_path = "/data"
          }
        }
      }
    }

    update_strategy {
      type = "RollingUpdate"

      rolling_update {
        partition = 1
      }
    } 

    volume_claim_template {
      metadata {
        name = "storage"
      }
      
      spec {
        storage_class_name = "standard"
        access_modes = ["ReadWriteOnce"] 
        selector {
          match_labels = {
            "app" = "storage"
          }
        }
        resources {
          requests = {
            storage = "1Gi"
          }
        }
      }
    }
  }
}
