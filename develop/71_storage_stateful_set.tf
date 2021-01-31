module "storage" {
  depends_on    = [helm_release.openebs]
  source        = "../modules/stateful-set"
  name          = "storage"
  image         = "minio/minio"
  image_version = "RELEASE.2020-11-25T22-36-25Z"
  internal_tcp  = [9000]
  external_tcp  = [9000]
  replicas      = 4
  storage       = "1Gi"
  args = [
    "server",
    "http://storage-0.storage.default.svc.cluster.local/data",
    "http://storage-1.storage.default.svc.cluster.local/data",
    "http://storage-2.storage.default.svc.cluster.local/data",
    "http://storage-3.storage.default.svc.cluster.local/data"
  ]
  mounts = [
    {
      claim_name     = "storage"
      sub_path       = ""
      container_path = "/data"
    }
  ]
  env = {
    MINIO_ACCESS_KEY = var.storage-access-key
    MINIO_SECRET_KEY = random_password.storage.result
  }
}
