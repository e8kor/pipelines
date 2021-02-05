variable "airflow-database-username" {
  type    = string
  default = "airflow"
}

variable "airflow-database-name" {
  type    = string
  default = "airflow"
}

resource "random_password" "airflow-database" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "helm_release" "airflow-database" {
  depends_on = [kubernetes_namespace.airflow]
  name       = "airflow-database"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  version    = "10.2.6"
  namespace  = "airflow"

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
    value = random_password.airflow-database.result
  }
  set {
    name  = "storageClassName"
    value = "openebs-jiva-default"
  }
  values = [
    file("${path.module}/helm_postgresql/values.yaml")
  ]
}

output "airflow-database-name" {
  value = var.database-name
}

output "airflow-database-username" {
  value = var.database-username
}

output "airflow-database-password" {
  value     = random_password.airflow-database.result
  sensitive = true
}
