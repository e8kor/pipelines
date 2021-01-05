resource "kubernetes_service" "minio" {
  metadata {
    name = "minio"
    labels = {
      "app" = "minio"
    }
  }
  spec {
    cluster_ip = "None"
    port {
      port        = 9000
      name = "minio"
      target_port = 80
    }
    selector = {
      app = "minio"
    }
  }
}