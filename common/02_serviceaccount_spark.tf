resource "kubernetes_service_account" "spark" {
  metadata {
    name = "spark"
    labels = {
      app      = "spark"
      resource = "service_account"
    }
  }
}
