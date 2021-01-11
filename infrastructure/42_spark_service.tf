resource "kubernetes_service" "external-spark" {
  depends_on = [kubernetes_deployment.spark-master]
  metadata {
    name = "external-spark"
    labels = {
      app      = "external-spark"
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

resource "kubernetes_service" "blockmanager-spark" {
  depends_on = [kubernetes_deployment.spark-master]
  metadata {
    name = "blockmanager-spark"
    labels = {
      app      = "blockmanager-spark"
      resource = "service"
    }
  }
  spec {
    cluster_ip = "None"
    port {
      port        = 7077
      target_port = 7077
    }
    selector = {
      app = "spark-master"
    }
  }
}
