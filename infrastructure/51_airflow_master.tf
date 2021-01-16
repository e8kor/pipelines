module "airflow" {
  depends_on = [ module.database ]
  source        = "../modules/service"
  name          = "airflow"
  image         = "e8kor/pipelines"
  image_version = "airflow"
  internal_tcp  = [8080, 5555, 8793]
  external_tcp  = [8080]
  replicas      = 1
  cpu    = "200m"
  mounts = [
    {
      claim_name     = "airflow-config"
      sub_path = ""
      container_path = "/usr/local/airflow"
    }
  ]
  config_volumes = [
    {
      claim_name = "airflow-config"
      config_map_name = "master-airflow-config"
    }
  ]
  env ={
    AIRFLOW__CORE__SQL_ALCHEMY_CONN="postgresql+psycopg2://${var.database_username}:${random_password.database.result}@database:5432/${var.database_name}"
    AIRFLOW__CORE__FERNET_KEY=external.fernet-key
    AIRFLOW__CORE__EXECUTOR=LocalExecutor
  }
}
