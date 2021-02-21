resource "kubernetes_service_account" "spark" {
  metadata {
    name = "spark"
    namespace = "spark"
    labels = {
      app      = "spark"
      resource = "service_account"
    }
  }
}
