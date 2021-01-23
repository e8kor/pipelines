resource "kubernetes_daemonset" "fs" {
  metadata {
    name      = "fs"
    labels = {
      app      = "fs"
      resource = "daemonset"
    }
  }
  spec {
    template {
      metadata {
        labels = {
          app = "fs"
          resource = "replicaset"
        }
      }
      spec {
        node_selector = {
          "node-role.kubernetes.io/fs" = ""
        }
        host_network = true
        container {
          image = "e8kor/glusterfs"
          name  = "fs"
          security_context {
            privileged = true
          }
          volume_mount {
            name= "glusterfs-heketi"
            mount_path = "/var/lib/heketi"
          }
          volume_mount {
            name= "glusterfs-run"
            mount_path = "/run"
          }
          volume_mount {
            name= "glusterfs-lvm"
            mount_path = "/run/lvm"
          }
          volume_mount {
            name= "glusterfs-etc"
            mount_path = "/etc/glusterfs"
          }
          volume_mount {
            name= "glusterfs-logs"
            mount_path = "/var/log/glusterfs"
          }
          volume_mount {
            name= "glusterfs-config"
            mount_path = "/var/lib/glusterd"
          }
          volume_mount {
            name= "glusterfs-dev"
            mount_path = "/dev"
          }
          volume_mount {
            name= "glusterfs-misc"
            mount_path = "/var/lib/misc/glusterfsd"
          }
          volume_mount {
            name= "glusterfs-cgroup"
            mount_path = "/sys/fs/cgroup"
            read_only = true
          }
          volume_mount {
            name= "glusterfs-ssl"
            mount_path = "/etc/ssl"
            read_only = true
          }
        }
        volume {
          name="glusterfs-heketi"
          host_path {
            path = "/var/lib/heketi"
          }
        }
        volume {
          name="glusterfs-lvm"
          host_path {
            path = "/var/lib/lvm"
          }
        }
        volume {
          name="glusterfs-logs"
          host_path {
            path = "/var/logs/glusterfs"
          }
        }
        volume {
          name="glusterfs-etc"
          host_path {
            path = "/etc/glusterfs"
          }
        }
        volume {
          name="glusterfs-config"
          host_path {
            path = "/var/lib/glusterd"
          }
        }
        volume {
          name="glusterfs-dev"
          host_path {
            path = "/dev"
          }
        }
        volume {
          name="glusterfs-misc"
          host_path {
            path = "/var/lib/misc/glusterfsd"
          }
        }
        volume {
          name="glusterfs-cgroup"
          host_path {
            path = "/sys/fs/cgroup"
          }
        }
        volume {
          name="glusterfs-ssl"
          host_path {
            path = "/etc/ssl"
          }
        }
        volume {
          name = "glusterfs-run"
        }
      }
    }
  }
}
