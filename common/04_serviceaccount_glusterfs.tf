resource "kubernetes_service_account" "fs" {
  metadata {
    name = "fs"
    labels = {
      app      = "fs"
      resource = "service_account"
    }
  }
}

resource "kubernetes_cluster_role" "fs" {
  metadata {
    name = "fs"
    labels = {
      app      = "fs"
      resource = "role"
    }
  }
  rule {
    api_groups = [""]
    resources  = ["persistentvolumes"]
    verbs= ["get", "list", "watch", "create", "delete"]
  }
  rule {
    api_groups = [""]
    resources  = ["persistentvolumeclaims"]
    verbs= ["get", "list", "watch", "update"]
  }
  rule {
    api_groups = [""]
    resources  = ["events", "pods/exec"]
    verbs= ["create", "update", "patch"]
  }
  rule {
    api_groups = [""]
    resources  = ["endpoints"]
    verbs= ["get", "list", "watch", "create", "update", "patch"]
  }
  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs= ["get", "list", "watch"]
  }
  rule {
    api_groups = [""]
    resources  = ["services"]
    verbs= ["get", "list", "watch", "create", "delete", "update", "patch"]
  }
  rule {
    api_groups = ["storage.k8s.io"]
    resources  = ["storageclasses"]
    verbs = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role_binding" "fs" {
  metadata {
    name = "fs"
    labels = {
      app      = "fs"
      resource = "role_binding"
    }
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "fs"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "fs"
    namespace = "default"
  }
}
