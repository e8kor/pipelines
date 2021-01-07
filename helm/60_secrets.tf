data "kubernetes_secret" "storage" {
  metadata {
    name = "storage"
  }
}

data "kubernetes_secret" "database" {
  metadata {
    name = "database"
  }

}

resource "kubernetes_secret" "storage-access-key" {
  # depends_on = [ helm_release.openfaas ]
  metadata {
    name      = "storage-access-key"
    namespace = "openfaas-fn"
  }

  data = {
    storage-access-key = lookup(data.kubernetes_secret.storage.data, "access_key")
  }
}

resource "kubernetes_secret" "storage-secret-key" {
  # depends_on = [ helm_release.openfaas ]
  metadata {
    name      = "storage-secret-key"
    namespace = "openfaas-fn"
  }

  data = {
    storage-secret-key = lookup(data.kubernetes_secret.storage.data, "secret_key")
  }
}

resource "kubernetes_secret" "database-name" {
  # depends_on = [ helm_release.openfaas ]
  metadata {
    name      = "database-name"
    namespace = "openfaas-fn"
  }

  data = {
    database-name = lookup(data.kubernetes_secret.database.data, "database_name")
  }
}

resource "kubernetes_secret" "database-password" {
  # depends_on = [ helm_release.openfaas ]
  metadata {
    name      = "database-password"
    namespace = "openfaas-fn"
  }

  data = {
    database-password = lookup(data.kubernetes_secret.database.data, "password")
  }
}

resource "kubernetes_secret" "database-username" {
  # depends_on = [ helm_release.openfaas ]
  metadata {
    name      = "database-username"
    namespace = "openfaas-fn"
  }

  data = {
    database-username = lookup(data.kubernetes_secret.database.data, "username")
  }
}