resource "kubernetes_config_map" "fs-provisioner-config" {
  metadata {
    name = "fs-provisioner-config"
    labels = {
      app      = "fs-provisioner"
      resource = "config"
    }
  }

  data = {
    "heketi.json" = file("${path.module}/heketi/heketi.json")
  }

}