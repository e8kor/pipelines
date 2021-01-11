resource "kubernetes_deployment" "spark-master" {
  metadata {
    name = "spark-master"
    labels = {
      app = "spark-master"
      resource = "deployment"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "spark-master"
      }
    }

    template {
      metadata {
        labels = {
          app = "spark-master"
          resource = "deployment"
        }
      }

      spec {
        container {
          name  = "spark-master"
          image = "e8kor/apache-spark:3.0.1"
          image_pull_policy = "Always"
          # command = [ "tail", "-F", "/opt/entrypoint.sh"]
          command = ["/opt/spark/bin/spark-class", "org.apache.spark.deploy.master.Master", "--ip", "0.0.0.0", "--port", "7077", "--webui-port", "8080", "--properties-file" , "/opt/spark/conf/spark-defaults.conf"]
          port {
            container_port = 7077
          }
          port {
            container_port = 8080
          }
          volume_mount {
            name       = "spark-defaults"
            mount_path = "/opt/spark/conf"
          }
          resources {
            requests {
              cpu    = "100m"
            }
          }
        }
        volume {
          name = "spark-defaults"
          config_map {
            name = "master-spark-defaults"
          }
        }
        node_name = "node6"
      }
    }
  }
}