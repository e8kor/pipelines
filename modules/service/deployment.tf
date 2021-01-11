resource "kubernetes_deployment" "deployment" {
  metadata {
    name = var.name
    labels = {
      app = var.name
      resource = "deployment"
    }
  }
  spec {
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
          resource = "deployment"
        }
      }
      spec {
        container {
          name  = var.name
          image = "${var.image}:${var.image_version}"
          args = var.args
          command = var.command
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
          dynamic "env" {
            for_each = var.env
            content {
              name  = env.key
              value = env.value
            }
          }
          resources {
            requests {
              memory = var.memory
              cpu = var.cpu
            }
          }
        }
        dynamic "volume" {
          for_each = var.config_volumes
          content {
            name     = volume.value.claim_name
            config_map {
              name = volume.value.config_map_name
            }
          }
        }
        node_selector = var.node_selector
      }
    }
    revision_history_limit = 5
  }

  timeouts {
    create = "15m"
  }
}