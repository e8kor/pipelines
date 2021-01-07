variable "database_username" {
  type    = string
  default = "postgres"
}

output "database_username" {
  value = var.database_username
}

variable "database_name" {
  type    = string
  default = "pipelines"
}

output "database_name" {
  value = var.database_name
}

resource "random_password" "database" {
  length           = 16
  special          = true
  override_special = "_%@"
}

output "database_password" {
  value     = random_password.database.result
  sensitive = true
}

resource "kubernetes_secret" "database" {
  metadata {
    name      = "database"
    namespace = "default"
  }

  data = {
    username      = var.database_username
    password      = random_password.database.result
    database_name = var.database_name
  }
}
