resource "kubernetes_service" "storage" {
  metadata {
    name = "storage"
    labels = {
      app = "storage"
    }
  }
  spec {
    cluster_ip = "None"
    port {
      port        = 9000
      name = "storage"
    }
    selector = {
      app = "storage"
    }
  }
}