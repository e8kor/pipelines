module "spark-master" {
  # depends_on = [ kubernetes_config_map.master-spark-defaults ]
  source        = "../modules/service"
  name          = "spark-master"
  image         = "e8kor/apache-spark"
  image_version = "3.0.1"
  internal_tcp  = [7077, 8080]
  external_tcp  = [7077]
  command = ["/opt/spark/bin/spark-class", "org.apache.spark.deploy.master.Master", "--ip", "0.0.0.0", "--port", "7077", "--webui-port", "8080", "--properties-file" , "/opt/spark/conf/spark-defaults.conf"]
  replicas      = 1
  cpu    = "100m"
  mounts = [
    {
      claim_name     = "spark-defaults"
      sub_path = ""
      container_path = "/opt/spark/conf"
    }
  ]
  config_volumes = [
    {
      claim_name = "spark-defaults"
      config_map_name = "master-spark-defaults"
    }
  ]
  node_selector = {
    "node-role.kubernetes.io/spark" = ""
  }
}
