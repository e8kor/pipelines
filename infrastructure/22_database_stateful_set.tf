module "database" {
  depends_on    = [kubernetes_persistent_volume.database-0]
  source        = "./modules/stateful-set"
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
      sub_path = ""
      container_path = "/docker-entrypoint-initdb.d"
    }
  ]
  config_volumes = [
    {
      name = "init-database"
      config_map_name = "init-database"
    }
  ]
  env = {
    POSTGRES_PASSWORD = random_password.database.result
    POSTGRES_USER     = var.database_username
    POSTGRES_DB       = var.database_name
  }
}
