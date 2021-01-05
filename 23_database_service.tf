resource "kubernetes_service" "external-database" {
  metadata {
    name = "database"
  }
  
  spec {
    selector = {
      app = "database"
    }

    port {
      port = 5432
      target_port = 5432
    }
  }
}