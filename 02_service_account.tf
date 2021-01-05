resource "kubernetes_secret" "admin" {
  metadata {
    name = "admin"
    namespace = "kube-system"
    annotations = {
      "kubernetes.io/service-account.name" = "admin"
    }
  }
  type = "kubernetes.io/service-account-token"
}

resource "kubernetes_service_account" "admin" {
  metadata {
    name = "admin"
    namespace = "kube-system"
  }
  secret {
    name = "admin"
  }
}

resource "kubernetes_cluster_role_binding" "admin" {
  metadata {
    name = "admin"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "admin"
    namespace = "kube-system"
  }
}
