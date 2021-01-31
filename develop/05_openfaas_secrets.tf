resource "kubernetes_secret" "storage-access-key" {
  depends_on = [kubernetes_namespace.openfaas-fn]
  metadata {
    name      = "storage-access-key"
    namespace = "openfaas-fn"
  }

  data = {
    storage-access-key = var.storage-access-key
  }
}

resource "kubernetes_secret" "storage-secret-key" {
  depends_on = [kubernetes_namespace.openfaas-fn]
  metadata {
    name      = "storage-secret-key"
    namespace = "openfaas-fn"
  }

  data = {
    storage-secret-key = random_password.storage.result
  }
}

resource "kubernetes_secret" "database-name" {
  depends_on = [kubernetes_namespace.openfaas-fn]
  metadata {
    name      = "database-name"
    namespace = "openfaas-fn"
  }

  data = {
    database-name = var.database-name
  }
}

resource "kubernetes_secret" "database-password" {
  depends_on = [kubernetes_namespace.openfaas-fn]
  metadata {
    name      = "database-password"
    namespace = "openfaas-fn"
  }

  data = {
    database-password = random_password.database.result
  }
}

resource "kubernetes_secret" "database-username" {
  depends_on = [kubernetes_namespace.openfaas-fn]
  metadata {
    name      = "database-username"
    namespace = "openfaas-fn"
  }

  data = {
    database-username = var.database-username
  }
}