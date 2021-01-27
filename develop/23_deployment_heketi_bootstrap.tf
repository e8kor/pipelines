resource "kubernetes_deployment" "fs-provisioner-bootstrap" {
  depends_on = [kubernetes_daemonset.fs, kubernetes_config_map.fs-provisioner-topology-config]
  metadata {
    name = "fs-provisioner-bootstrap"
    labels = {
      app      = "fs-provisioner"
      resource = "deployment"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app      = "fs-provisioner"
        resource = "pod"
        type     = "bootstrap"
      }
    }
    template {
      metadata {
        labels = {
          app      = "fs-provisioner"
          resource = "pod"
          type     = "bootstrap"
        }
      }
      spec {
        node_selector = {
          "node-role.kubernetes.io/fs-provisioner" = ""
        }
        service_account_name = "fs-provisioner"
        container {
          image             = "e8kor/heketi"
          image_pull_policy = "Always"
          name              = "fs-provisioner"
          port {
            container_port = 8080
          }
          env {
            name = "HEKETI_CLI_SERVER"
            value = "http://localhost:8080"
          }
          env {
            name = "HEKETI_CLI_USER"
            value_from {
              secret_key_ref {
                name = "fs-provisioner"
                key = "username"
              }
            }
          }
          env {
            name= "HEKETI_CLI_KEY"
            value_from {
              secret_key_ref {
                name = "fs-provisioner"
                key = "secret"
              }
            }
          }
          env {
            name= "HEKETI_ADMIN_KEY"
            value_from {
              secret_key_ref {
                name = "fs-provisioner"
                key = "secret"
              }
            }
          }
          env {
            name  = "HEKETI_EXECUTOR"
            value = "kubernetes"
          }
          env {
            name  = "HEKETI_DB_PATH"
            value = "/var/lib/heketi/heketi.db"
          }
          env {
            name = "HEKETI_TOPOLOGY_FILE"
            value =  "/etc/heketi/topology/default.json"
          }
          env {
            name  = "HEKETI_FSTAB"
            value = "/var/lib/heketi/fstab"
          }
          env {
            name  = "HEKETI_SNAPSHOT_LIMIT"
            value = "14"
          }
          env {
            name  = "HEKETI_KUBE_GLUSTER_DAEMONSET"
            value = "y"
          }
          env {
            name  = "HEKETI_IGNORE_STALE_OPERATIONS"
            value = "true"
          }
          volume_mount {
            name       = "db-secret"
            mount_path = "/backupdb"
          }
          volume_mount {
            name       = "db"
            mount_path = "/var/lib/heketi"
          }
          volume_mount {
            name       = "topology-config"
            mount_path = "/etc/heketi/topology"
          }
          volume_mount {
            name       = "config"
            mount_path = "/etc/heketi"
          }
          # readiness_probe {
          #   http_get {
          #     path = "/hello"
          #     port = 8080
          #   }
          #   timeout_seconds       = 3
          #   initial_delay_seconds = 3
          # }
          # liveness_probe {
          #   http_get {
          #     path = "/hello"
          #     port = 8080
          #   }
          #   timeout_seconds       = 3
          #   initial_delay_seconds = 3
          # }
        }
        volume {
          name = "db"
        }
        volume {
          name = "topology-config"
          config_map {
            name = "fs-provisioner-topology-config"
          }
        }
        volume {
          name = "config"
          config_map {
            name = "fs-provisioner-config"
          }
        }
        volume {
          name = "db-secret"
          secret {
            secret_name = "fs-db-secret"
          }
        }
      }
    }
  }
}
