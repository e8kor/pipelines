resource "kubernetes_service" "service-storage" {
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
resource "kubernetes_service" "external-storage" {
  metadata {
    name = "external-storage"
  }
  
  spec {
    session_affinity = "ClientIP"
    type = "LoadBalancer"
    selector = {
      app = "storage"
    }

    port {
      port = 9000
      target_port = 9000
    }
  }
}