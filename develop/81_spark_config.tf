resource "kubernetes_config_map" "master-spark-defaults" {
  metadata {
    name = "master-spark-defaults"
    labels = {
      app      = "spark-defaults"
      resource = "config"
    }
  }

  data = {
    "spark-defaults.conf" = file("${path.module}/spark/master-spark-defaults.conf")
  }

}

resource "kubernetes_service" "external-spark" {
  depends_on = [module.spark-master]
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
