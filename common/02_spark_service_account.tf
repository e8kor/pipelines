resource "kubernetes_service_account" "spark" {
  metadata {
    name = "spark"
    namespace = "default"
    labels = {
      app      = "spark"
      resource = "service_account"
    }
  }
}

resource "kubernetes_cluster_role_binding" "spark" {
  metadata {
    name = "spark"
    labels = {
      app      = "spark"
      resource = "role_binding"
    }
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "edit"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "spark"
    namespace = "default"
  }
}
