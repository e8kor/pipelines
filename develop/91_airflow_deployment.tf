# data "external" "fernet-key" {
#   program = ["bash", "${path.module}/airflow/fernet"]
#   query   = {}
# }


# resource "kubernetes_config_map" "master-airflow-config" {
#   metadata {
#     name      = "master-airflow-config"
#     namespace = "airflow"
#     labels = {
#       app      = "airflow-config"
#       resource = "config"
#     }
#   }

#   data = {
#     "airflow.conf" = file("${path.module}/airflow/airflow.cfg")
#   }

# }
# module "airflow" {
#   depends_on    = [kubernetes_namespace.airflow, helm_release.airflow-database, kubernetes_config_map.master-airflow-config]
#   source        = "../modules/service"
#   name          = "airflow"
#   namespace     = "airflow"
#   image         = "e8kor/pipelines"
#   image_version = "airflow"
#   internal_tcp  = [8080, 5555, 8793]
#   external_tcp  = [8080]
#   replicas      = 1
#   cpu           = "200m"
#   command       = ["tail", "-f", "/entrypoint.sh"]
#   mounts = [
#     {
#       claim_name     = "airflow-config"
#       sub_path       = ""
#       container_path = "/usr/local/airflow"
#     }
#   ]
#   config_volumes = [
#     {
#       claim_name      = "airflow-config"
#       config_map_name = "master-airflow-config"
#     }
#   ]
#   env = {
#     AIRFLOW__CORE__SQL_ALCHEMY_CONN = "postgresql+psycopg2://${var.airflow-database-username}:${random_password.airflow-database.result}@airflow-database-postgresql:5432/${var.airflow-database-name}"
#     AIRFLOW__CORE__FERNET_KEY       = lookup(data.external.fernet-key.result, "data")
#     AIRFLOW__CORE__EXECUTOR         = "LocalExecutor"
#   }
# }
