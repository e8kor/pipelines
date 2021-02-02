module "airflow" {
  depends_on    = [module.airflow-database, kubernetes_config_map.master-airflow-config]
  source        = "../modules/service"
  name          = "airflow"
  image         = "e8kor/pipelines"
  image_version = "airflow"
  internal_tcp  = [8080, 5555, 8793]
  external_tcp  = [8080]
  replicas      = 1
  cpu           = "200m"
  command       = ["tail", "-f", "/entrypoint.sh"]
  mounts = [
    {
      claim_name     = "airflow-config"
      sub_path       = ""
      container_path = "/usr/local/airflow"
    }
  ]
  config_volumes = [
    {
      claim_name      = "airflow-config"
      config_map_name = "master-airflow-config"
    }
  ]
  env = {
    AIRFLOW__CORE__SQL_ALCHEMY_CONN = "postgresql+psycopg2://${var.airflow-db-username}:${random_password.airflow-db.result}@airflow-db:5432/${var.airflow-db-name}"
    AIRFLOW__CORE__FERNET_KEY       = lookup(data.external.fernet-key.result, "data")
    AIRFLOW__CORE__EXECUTOR         = "LocalExecutor"
  }
}

module "airflow-database" {
  depends_on    = [helm_release.openebs]
  source        = "../modules/stateful-set"
  name          = "airflow-db"
  image         = "postgres"
  image_version = "latest"
  internal_tcp  = [5432]
  external_tcp  = [5432]
  replicas      = 1
  storage       = "5Gi"
  memory        = "256Mi"
  mounts = [
    {
      claim_name     = "airflow-db"
      sub_path       = "data"
      container_path = "/local/lib/postgresql/data"
    }
  ]
  config_volumes = []
  env = {
    POSTGRES_PASSWORD = random_password.airflow-db.result
    POSTGRES_USER     = var.airflow-db-username
    POSTGRES_DB       = var.airflow-db-name
  }
}
