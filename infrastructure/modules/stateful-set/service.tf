resource "kubernetes_service" "service" {
  depends_on = [ kubernetes_stateful_set.stateful-set ]
  metadata {
    name = var.name
    labels = {
      app = var.name
      resource = "service"
    }
  }
  
  spec {
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
resource "kubernetes_service" "service-access" {
  depends_on = [ kubernetes_stateful_set.stateful-set ]
  metadata {
    name = "${var.name}-service"
    labels = {
      app = var.name
      resource = "service-access"
    }
  }
  
  spec {
    type = "ClusterIP"
    dynamic "port" {
      for_each = var.internal_tcp
      content {
        port = port.value
        name = "tcp-int-${port.key}"
        protocol = "TCP"
      }
    }
    selector = {
      app = var.name
    }
  }
}
