resource "kubernetes_service" "storage-service" {
  metadata {
    name = "storage-service"
  }
  spec {
    type = "NodePort"
    port {
      port      = 9000
      node_port = 30000
    }
    selector = {
      app = "storage"
    }
  }
}