resource "kubernetes_ingress" "spark-ingress" {
  depends_on = [kubernetes_deployment.spark-master]
  metadata {
    name = "spark-ingress"
    labels = {
      "app" = "spark-ingress"
      resource = "ingress"
    }
  }

  spec {
    rule{
      host = "spark-kubernetes"
      http {
        path {
          backend {
            service_name = "spark-master"
            service_port = 8080
          }
        }
    }
    }
  }
}
