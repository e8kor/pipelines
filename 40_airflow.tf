# module "airflow" {
#   source      = "./modules/service"
#   name        = "airflow"
#   image       = "pipelines"
#   image_version = "airflow"
#   internal_tcp = [9000]
#   external_tcp = [9000]
#   replicas = 1
#   memory = "256Mi"
#   mounts = [
#     {
#       claim_name = "storage"
#       sub_path = "storage"
#       container_path = "/mnt/data"
#     }
#   ]
#   env = {
#       MINIO_ACCESS_KEY = var.storage_access_key
#       MINIO_SECRET_KEY = random_password.storage.result
#   }
# }
