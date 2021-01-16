data "external" "fernet-key" {
  program = ["python", "${path.module}/airflow/fernet.py"]
  query = {}
}

resource "kubernetes_config_map" "master-airflow-config" {
  metadata {
    name = "master-airflow-config"
    labels = {
      app      = "airflow-config"
      resource = "config"
    }
  }

  data = {
    "airflow.conf" = file("${path.module}/airflow/airflow.conf")
  }

}