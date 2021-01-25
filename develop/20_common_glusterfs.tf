resource "kubernetes_service" "fs" {
  metadata {
    name     = "fs"
    labels = {
      app = "fs"
      resource = "service"
    }
  }
  spec {
    port {
      port = 1
    }
  }
}

resource "kubernetes_endpoints" "fs" {
  metadata {
    name     = "fs"
    labels = {
      app = "fs"
      resource = "endpoints"
    }
  }
  subset {
    address {
      ip = "192.168.0.211"
    }
    address {
      ip = "192.168.0.212"
    }
    address {
      ip = "192.168.0.213"
    }
    address {
      ip = "192.168.0.214"
    }
    address {
      ip = "192.168.0.215"
    }
    address {
      ip = "192.168.0.216"
    }
    port {
      port = 1
    }
  }
}