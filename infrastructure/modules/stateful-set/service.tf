resource "kubernetes_service" "external-accessor" {
  metadata {
    name = var.name
    labels = {
      app = var.name
    }
  }
  
  spec {
    cluster_ip = "None"
    dynamic "port" {
      for_each = var.internal_tcp
      content {
        port = port.value
        # host_port = port.value # if deployment fails comment out field
        protocol     = "TCP"
        name         = "tcp-int-${port.key}"
      }
    }
    selector = {
      app = var.name
    }
  }
}