resource "kubernetes_stateful_set" "database" {
  metadata {
    name = "database"
  }

  spec {
    service_name = "database"
    replicas = 1
    revision_history_limit = 2

    selector {
      match_labels = {
        app = "database"
      }
    }

    template {
      metadata {
        labels = {
          app = "database"
        }
      }

      spec {
        container {
          name = "database"
          image = "postgres"
          image_pull_policy = "IfNotPresent"
          env {
            name = "POSTGRES_USER"
            value = var.database_username
          }
          env {
            name = "POSTGRES_DB" 
            value = var.database_name
          }
          env {
            name = "POSTGRES_PASSWORD"
            value = random_password.database.result
          }

          volume_mount {
            name = "database"
            mount_path = "/var/lib/postgresql/data"
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
        name = "database"
      }
      spec {
        storage_class_name = "standard"
        access_modes       = ["ReadWriteOnce"]
        selector {
          match_labels = {
            "app" = "database"
          }
        }
        resources {
          requests = {
            storage = "2Gi"
          }
        }
      }
    }
  } 
}
