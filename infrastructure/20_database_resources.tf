resource "kubernetes_config_map" "init-database" {
  metadata {
    name = "init-database"
    labels = {
      app      = "database"
      resource = "config"
    }
  }

  data = {
    "01_init-user-db.sql" = "${file("${path.module}/database/01_init-user-db.sql")}"
  }

}