module "database-volume" {
  source      = "./modules/volume"
  name        = "database"
  storage = "2Gi"
  storage_path = "/mnt"
}
