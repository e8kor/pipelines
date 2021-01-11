locals {
  volumes = distinct([for mount in var.mounts : mount.claim_name])
}

resource "kubernetes_deployment" "deployment" {
  metadata {
    name = var.name
    labels = {
      app = var.name
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
        dynamic "volume" {
          for_each = local.volumes
          content {
            name = volume.value
            persistent_volume_claim {
              claim_name = volume.value
            }
          }
        }
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
      }
    }
    revision_history_limit = 5
  }

  timeouts {
    create = "15m"
  }
}