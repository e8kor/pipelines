resource "kubernetes_service_account" "fs-provisioner" {
  metadata {
    name = "fs-provisioner"
    labels = {
      app      = "fs-provisioner"
      resource = "service_account"
    }
  }
}

resource "kubernetes_cluster_role" "fs-provisioner" {
  metadata {
    name = "fs-provisioner"
    labels = {
      app      = "fs-provisioner"
      resource = "role"
    }
  }
  rule {
    api_groups = [""]
    resources  = ["pods","pods/status","pods/exec"]
    verbs= ["get", "list", "watch"]
  }
  rule {
    api_groups = [""]
    resources  = ["pods","pods/status","pods/exec"]
    verbs = ["get","list","watch","create"]
  }
}

resource "kubernetes_cluster_role_binding" "fs-provisioner" {
  metadata {
    name = "fs-provisioner"
    labels = {
      app      = "fs-provisioner"
      resource = "role_binding"
    }
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "fs-provisioner"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "fs-provisioner"
    namespace = "default"
  }
}