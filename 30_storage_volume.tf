module "storage-volume" {
  source      = "./modules/volume"
  name        = "storage"
  storage = "5Gi"
  storage_path = "/mnt"
}
