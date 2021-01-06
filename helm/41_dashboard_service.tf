resource "kubernetes_service" "kubernetes-dashboard" {
  metadata {
    name = "kubernetes-dashboard"
    labels = {
      k8s-app = "kubernetes-dashboard"
    }
  }
  spec {
    session_affinity = "ClientIP"
    type = "LoadBalancer"
    selector = {
      k8s-app = "kubernetes-dashboard"
    }

    port {
      port = 9000
      target_port = 9000
    }
  }
  
}