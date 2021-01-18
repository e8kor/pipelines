resource "kubernetes_secret" "volumes-secret" {
  metadata {
    name      = "volumes-secret"
  }
  type = "kubernetes.io/glusterfs"

  data = {
    key = "AdminPass"
  }
}