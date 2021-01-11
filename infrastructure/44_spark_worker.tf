resource "kubernetes_deployment" "spark-worker" {
  depends_on = [kubernetes_service.blockmanager-spark]
  metadata {
    name = "spark-worker"
    labels = {
      app = "spark-worker"
      resource = "deployment"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "spark-worker"
      }
      
    }

    template {
      metadata {
        labels = {
          app = "spark-worker"
          resource = "deployment"
        }
      }

      spec {
        container {
          name  = "spark-worker"
          image = "e8kor/apache-spark:3.0.1"
          # command = [ "tail", "-F", "/opt/entrypoint.sh"]
          command = ["/opt/spark/bin/spark-class", "org.apache.spark.deploy.worker.Worker", "spark://blockmanager-spark:7077", "--webui-port", "8081"]
          port {
            container_port = 8081
          }
          resources {
            requests {
              cpu    = "100m"
            }
          }
        }
        # node_selector = {
        #   "model" = "pi4"
        # }
      }
    }
  }
}