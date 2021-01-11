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