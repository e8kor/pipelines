resource "kubernetes_service" "service" {
  depends_on = [ kubernetes_stateful_set.stateful-set ]
  metadata {
    name = var.name
    labels = {
      app = var.name
    }
  }
  
  spec {
    publish_not_ready_addresses = true
    cluster_ip = "None"
    dynamic "port" {
      for_each = var.internal_tcp
      content {
        port = port.value
        name = "tcp-int-${port.key}"
      }
    }
    selector = {
      app = var.name
    }
  }
}