data "external" "fernet-key" {
  program = ["bash", "${path.module}/airflow/fernet"]
  query   = {}
}

variable "airflow-db-username" {
  type    = string
  default = "airflow"
}

variable "airflow-db-name" {
  type    = string
  default = "airflow"
}

resource "random_password" "airflow-db" {
  length           = 16
  special          = true
  override_special = "_%@"
}

output "airflow-db-name" {
  value = var.database-name
}

output "airflow-db-username" {
  value = var.database-username
}

output "airflow-db-password" {
  value     = random_password.database.result
  sensitive = true
}

resource "kubernetes_config_map" "master-airflow-config" {
  metadata {
    name = "master-airflow-config"
    labels = {
      app      = "airflow-config"
      resource = "config"
    }
  }

  data = {
    "airflow.conf" = file("${path.module}/airflow/airflow.cfg")
  }

}

