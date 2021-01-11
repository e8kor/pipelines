locals {
  entrypoints = var.public ? "https-public" : "https-local"
  publicity = var.public ? "public" : "local"
}

resource "kubernetes_service" "service" {
  count = length(var.internal_tcp)
  metadata {
    name      = "${var.name}-tcp"
    namespace = "default"
    labels = {
      app = var.name
      resource = "service"
    }
  }
  spec {
    type = "LoadBalancer"
    selector = {
      app = var.name
    }
    
    port {
      port    = var.internal_tcp[count.index]
      target_port = var.external_tcp[count.index]
    }
  }
} 

output "internal_ip" {
  value = length(kubernetes_service.service) > 0 ? kubernetes_service.service[0].spec[0].cluster_ip : null
}