resource "kubernetes_service" "external-storage" {
  depends_on = [module.storage]
  metadata {
    name = "external-storage"
  }
  spec {
    type = "NodePort"
    port {
      port        = 9000
      target_port = 9000
      node_port = 30000
    }
    selector = {
      app = "storage"
    }
  }
}
