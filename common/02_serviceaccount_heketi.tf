resource "kubernetes_service_account" "fs-provisioner" {
  metadata {
    name = "fs-provisioner"
    labels = {
      app      = "fs-provisioner"
      resource = "service_account"
    }
  }
}
