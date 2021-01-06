module "database" {
  source      = "./modules/stateful-set"
  name        = "database"
  image       = "postgres"
  image_version = "latest"
  internal_tcp = [5432]
  external_tcp = [5432]
  replicas = 1
  memory = "256Mi"
  mounts = [
    {
      claim_name = "database"
      sub_path = "database"
      container_path = "/local/lib/postgresql/data"
    }
  ]
  env = {
    POSTGRES_PASSWORD = random_password.database.result
    POSTGRES_USER = var.database_username
    POSTGRES_DB = var.database_name
  }
}
