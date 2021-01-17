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

module "spark-master" {
  depends_on    = [kubernetes_config_map.master-spark-defaults]
  source        = "../modules/service"
  name          = "spark-master"
  image         = "e8kor/apache-spark"
  image_version = "3.0.1"
  internal_tcp  = [7077, 8080]
  external_tcp  = [7077]
  command       = ["/opt/spark/bin/spark-class", "org.apache.spark.deploy.master.Master", "--ip", "0.0.0.0", "--port", "7077", "--webui-port", "8080", "--properties-file", "/opt/spark/conf/spark-defaults.conf"]
  replicas      = 1
  cpu           = "100m"
  mounts = [
    {
      claim_name     = "spark-defaults"
      sub_path       = ""
      container_path = "/opt/spark/conf"
    }
  ]
  config_volumes = [
    {
      claim_name      = "spark-defaults"
      config_map_name = "master-spark-defaults"
    }
  ]
  node_selector = {
    "node-role.kubernetes.io/spark" = ""
  }
}

module "spark-worker" {
  depends_on    = [module.spark-master]
  source        = "../modules/service"
  name          = "spark-worker"
  image         = "e8kor/apache-spark"
  image_version = "3.0.1"
  internal_tcp  = [8081]
  command       = ["/opt/spark/bin/spark-class", "org.apache.spark.deploy.worker.Worker", "spark://spark-master-tcp-0:7077", "--webui-port", "8081"]
  replicas      = 2
  cpu           = "100m"
  node_selector = {
    "node-role.kubernetes.io/spark" = ""
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

