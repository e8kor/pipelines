module "spark-worker" {
  # depends_on = [ module.spark-master ]
  source        = "../modules/service"
  name          = "spark-worker"
  image         = "e8kor/apache-spark"
  image_version = "3.0.1"
  internal_tcp  = [8081]
  command = ["/opt/spark/bin/spark-class", "org.apache.spark.deploy.worker.Worker", "spark://spark-master-tcp-0:7077", "--webui-port", "8081"]
  replicas      = 2
  cpu    = "100m"
  node_selector = {
    "node-role.kubernetes.io/spark" = ""
  }
}
