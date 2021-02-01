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

resource "kubernetes_config_map" "init-database" {
  metadata {
    name = "init-database"
    labels = {
      app      = "database"
      resource = "config"
    }
  }

  data = {
    "01_init-user-db.sql"      = file("${path.module}/database/01_init-user-db.sql")
  }

}

resource "kubernetes_service" "external-database" {
  depends_on = [module.database]
  metadata {
    name = "external-database"
    labels = {
      app      = "database"
      resource = "service"
    }
  }
  spec {
    type = "NodePort"
    port {
      port        = 5432
      target_port = 5432
      node_port   = 32345
    }
    selector = {
      app = "database"
    }
  }
}
