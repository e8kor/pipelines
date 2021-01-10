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
          args = ["driver", "--conf", "spark.kubernetes.authenticate.driver.serviceAccountName=spark", "org.apache.spark.deploy.master.Master", "--ip", "spark-master", "--port", "7077", "--webui-port", "8080"]
          port {
            container_port = 7077
          }
          port {
            container_port = 8080
          }
          resources {
            requests {
              cpu    = "100m"
            }
          }
        }
        node_name = "node6"
      }
    }
  }
}