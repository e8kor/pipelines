resource "kubernetes_config_map" "init-database" {
  metadata {
    name = "init-database"
    labels = {
      app      = "database"
      resource = "config"
    }
  }

  data = {
    "01_init-airflow-db.sh"    = file("${path.module}/database/01_init-airflow-db.sh")
    "02_init-airflow-user.sql" = file("${path.module}/database/02_init-airflow-user.sql")
    "03_init-user-db.sql"      = file("${path.module}/database/03_init-user-db.sql")
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
