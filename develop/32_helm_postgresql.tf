variable "database-username" {
  type    = string
  default = "postgres"
}

variable "database-name" {
  type    = string
  default = "pipelines"
}

resource "random_password" "database" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "kubernetes_config_map" "init-database" {
  depends_on = [kubernetes_namespace.database]
  metadata {
    name      = "init-database"
    namespace = "database"
    labels = {
      app      = "database"
      resource = "config"
    }
  }

  data = {
    "01_init-user-db.sql" = file("${path.module}/database/01_init-user-db.sql")
  }

}

resource "helm_release" "database" {
  depends_on = [kubernetes_namespace.database, kubernetes_storage_class.cstor, helm_release.openebs]
  name       = "database"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  version    = "10.2.6"
  namespace  = "database"

  set {
    name  = "image.repository"
    value = "postgres"
  }
  set {
    name  = "image.tag"
    value = "10-alpine"
  }
  set {
    name  = "postgresqlDatabase"
    value = var.database-name
  }
  set {
    name  = "postgresqlUsername"
    value = var.database-username
  }
  set {
    name  = "postgresqlPassword"
    value = random_password.database.result
  }
  set {
    name  = "initdbScriptsConfigMap"
    value = "init-database"
  }
  set {
    name  = "persistence.storageClass"
    value = "openebs-jiva-default"
  }
  set {
    name  = "persistence.size"
    value = "30Gi"
  }
  values = [
    file("${path.module}/helm_postgresql/values.yaml")
  ]
}

output "database-name" {
  value = var.database-name
}

output "database-username" {
  value = var.database-username
}

output "database-password" {
  value     = random_password.database.result
  sensitive = true
}
