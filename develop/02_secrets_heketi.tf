
resource "kubernetes_secret" "fs-provisioner-db-backup" {
  metadata {
    name = "fs-provisioner-db-backup"
  }
  type = "kubernetes.io/glusterfs"

  data = {}
}

resource "kubernetes_secret" "fs-config-secret" {
  metadata {
    name = "fs-config-secret"
  }
  type = "kubernetes.io/glusterfs"

  data = {
    key = "AdminPass"
  }
}