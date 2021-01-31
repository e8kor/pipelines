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
