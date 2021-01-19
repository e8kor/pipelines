resource "kubernetes_stateful_set" "stateful-set" {
  metadata {
    name = var.name
  }

  spec {
    service_name = var.name
    replicas = var.replicas
    selector {
      match_labels = {
        app = var.name
      }
    }
    template {
      metadata {
        labels = {
          app = var.name
          resource = "stateful-set"
        }
      }
      spec {
        container {
          name  = var.name
          image = "${var.image}:${var.image_version}"
          image_pull_policy = "IfNotPresent"
          args = var.args
          command = var.command
          resources {
            requests {
              memory = var.memory
              cpu = var.cpu
            }
          }
          dynamic "env" {
            for_each = var.env
            content {
              name  = env.key
              value = env.value
            }
          }
          dynamic "port" {
            for_each = var.internal_tcp
            content {
              container_port = port.value
              protocol     = "TCP"
              name         = "tcp-int-${port.key}"
            }
          }
          dynamic "volume_mount" {
            for_each = var.mounts
            content {
              name     = volume_mount.value.claim_name
              sub_path   = volume_mount.value.sub_path
              mount_path = volume_mount.value.container_path
            }
          }
        }
        dynamic "volume" {
          for_each = var.config_volumes
          content {
            name     = volume.value.name
            config_map {
              name = volume.value.config_map_name
            }
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
        name = var.name
        annotations = {
          "volume.beta.kubernetes.io/storage-class"= "volumes"
        }
      }
      spec {
        storage_class_name = "volumes"
        access_modes = ["ReadWriteOnce"] 
        resources {
          requests = {
            storage = var.storage
          }
        }
      }
    }
    revision_history_limit = 5
  }
}
