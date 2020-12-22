module "storage" {
  source      = "./modules/service"
  name        = "minio"
  image       = "minio/minio"
  image_version = "RELEASE.2020-11-25T22-36-25Z"
  internal_tcp = [9000]
  external_tcp = [9000]
  replicas = 1
  args = [ "server", "/mnt/data" ]
  memory = "128Mi"
  mounts = [
    {
      claim_name = "storage"
      sub_path = "storage"
      container_path = "/mnt/data"
    }
  ]
  env = {
      MINIO_ACCESS_KEY = var.storage_access_key
      MINIO_SECRET_KEY = random_password.storage.result
  }
}

module "storage-volume" {
  source      = "./modules/volume"
  name        = "storage"
  storage = "5Gi"
  storage_path = "/mnt"
}
