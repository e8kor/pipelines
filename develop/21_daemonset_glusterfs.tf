resource "kubernetes_daemonset" "fs" {
  metadata {
    name = "fs"
    labels = {
      app      = "fs"
      resource = "daemonset"
    }
  }
  spec {
    selector {
      match_labels = {
        app      = "fs"
        resource = "daemonset"
      }
    }
    template {
      metadata {
        name = "fs"
        labels = {
          app      = "fs"
          resource = "daemonset"
        }
      }
      spec {
        node_selector = {
          "node-role.kubernetes.io/fs" = ""
        }
        host_network = true
        container {
          image             = "e8kor/glusterfs"
          image_pull_policy = "Always"
          name              = "fs"
          security_context {
            privileged = true
            capabilities { }
          }
          volume_mount {
            name       = "glusterfs-heketi"
            mount_path = "/var/lib/heketi"
          }
          volume_mount {
            name       = "glusterfs-run"
            mount_path = "/run"
          }
          volume_mount {
            name       = "glusterfs-lvm"
            mount_path = "/run/lvm"
          }
          volume_mount {
            name       = "glusterfs-etc"
            mount_path = "/etc/glusterfs"
          }
          volume_mount {
            name       = "glusterfs-logs"
            mount_path = "/var/log/glusterfs"
          }
          volume_mount {
            name       = "glusterfs-config"
            mount_path = "/var/lib/glusterd"
          }
          volume_mount {
            name       = "glusterfs-dev"
            mount_path = "/dev"
          }
          volume_mount {
            name       = "glusterfs-cgroup"
            mount_path = "/sys/fs/cgroup"
            read_only  = true
          }
        }
        volume {
          name = "glusterfs-heketi"
          host_path {
            path = "/var/lib/heketi"
          }
        }
        volume {
          name = "glusterfs-run"
        }
        volume {
          name = "glusterfs-lvm"
          host_path {
            path = "/run/lvm"
          }
        }
        volume {
          name = "glusterfs-etc"
          host_path {
            path = "/etc/glusterfs"
          }
        }
        volume {
          name = "glusterfs-logs"
          host_path {
            path = "/var/logs/glusterfs"
          }
        }
        volume {
          name = "glusterfs-config"
          host_path {
            path = "/var/lib/glusterd"
          }
        }
        volume {
          name = "glusterfs-dev"
          host_path {
            path = "/dev"
          }
        }
        volume {
          name = "glusterfs-cgroup"
          host_path {
            path = "/sys/fs/cgroup"
          }
        }
      }
    }
  }
}
