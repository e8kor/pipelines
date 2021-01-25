resource "kubernetes_secret" "fs-config-secret" {
  metadata {
    name = "fs-config-secret"
  }

  data = {
    key = "ivd7dfORN7QNeKVO"
  }
}

resource "kubernetes_secret" "fs-db-secret" {
  metadata {
    name = "fs-db-secret"
  }

  data = {}
}


resource "kubernetes_config_map" "fs-provisioner-config" {
  metadata {
    name = "fs-provisioner-config"
    labels = {
      app      = "fs-provisioner-config"
      resource = "config"
    }
  }

  data = {
    "heketi.json"    = file("${path.module}/heketi/heketi.json")
    "topology.json"  = file("${path.module}/heketi/topology.json")
    "heketi_key"     = file("${path.module}/heketi/heketi_key")
    "heketi_key.pub" = file("${path.module}/heketi/heketi_key.pub")
  }
}

resource "kubernetes_service" "fs-provisioner" {
  metadata {
    name = "fs-provisioner"
    labels = {
      app      = "fs-provisioner"
      resource = "service"
    }
  }
  spec {
    selector = {
      app      = "fs-provisioner"
      resource = "pod"
    }

    port {
      name        = "fs-provisioner"
      port        = 8080
      target_port = 8080
    }
  }
} 