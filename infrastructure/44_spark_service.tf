resource "kubernetes_service" "external-spark" {
  depends_on = [kubernetes_deployment.spark-master]
  metadata {
    name = "external-storage"
    labels = {
      app      = "external-storage"
      resource = "service"
    }
  }
  spec {
    type = "NodePort"
    port {
      port        = 8080
      target_port = 8080
      node_port   = 30080
    }
    selector = {
      app = "spark-master"
    }
  }
}
