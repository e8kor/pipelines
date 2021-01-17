resource "kubernetes_config_map" "init-database" {
  metadata {
    name = "init-database"
    labels = {
      app      = "database"
      resource = "config"
    }
  }

  data = {
    "01_init-airflow-user.sql" = file("${path.module}/database/01_init-airflow-user.sql")
    "02_init-airflow-db.sql"   = file("${path.module}/database/02_init-airflow-db.sql")
    "03_init-user-db.sql"      = file("${path.module}/database/03_init-user-db.sql")
  }

}

module "database" {
  depends_on    = [kubernetes_config_map.init-database, kubernetes_storage_class.volumes]
  source        = "../modules/stateful-set"
  name          = "database"
  image         = "postgres"
  image_version = "latest"
  internal_tcp  = [5432]
  external_tcp  = [5432]
  replicas      = 1
  storage       = "1Gi"
  memory        = "256Mi"
  mounts = [
    {
      claim_name     = "database"
      sub_path       = "data"
      container_path = "/local/lib/postgresql/data"
      }, {
      claim_name     = "init-database"
      sub_path       = ""
      container_path = "/docker-entrypoint-initdb.d"
    }
  ]
  config_volumes = [
    {
      name            = "init-database"
      config_map_name = "init-database"
    }
  ]
  env = {
    POSTGRES_PASSWORD = random_password.database.result
    POSTGRES_USER     = var.database-username
    POSTGRES_DB       = var.database-name
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
