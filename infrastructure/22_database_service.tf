resource "kubernetes_service" "external-database" {
  depends_on = [module.database]
  metadata {
    name = "external-database"
  }
  spec {
    type = "NodePort"
    port {
      port        = 5432
      target_port = 5432
      node_port = 32345
    }
    selector = {
      app = "database"
    }
  }
}
