resource "kubernetes_namespace" "spark" {
  metadata {
    labels = {
      app      = "spark"
      resource = "namespace"
    }
    name = "spark"
  }
}

resource "kubernetes_config_map" "master-spark-defaults" {
  metadata {
    name      = "master-spark-defaults"
    namespace = "spark"
    labels = {
      app      = "spark-defaults"
      resource = "config"
    }
  }
  data = {
    "spark-defaults.conf" = <<EOT
spark.jars.packages org.apache.hadoop:hadoop-aws:3.2.0,org.apache.hadoop:hadoop-common:3.2.0,com.amazonaws:aws-java-sdk-bundle:1.11.874
spark.app.id KubernetesSpark
spark.master k8s://https://kubernetes.default
spark.kubernetes.pyspark.pythonVersion 3
spark.kubernetes.executor.label.spark executor
spark.kubernetes.container.image e8kor/spark-py:3.0.2
spark.kubernetes.authenticate.driver.serviceAccountName spark
spark.kubernetes.namespace spark
spark.submit.deployMode client
spark.driver.port 7778
spark.driver.extraLibraryPath /opt/hadoop/lib/native
spark.hadoop.fs.s3a.endpoint http://external-storage.storage:9000
spark.hadoop.fs.s3a.access.key ${var.storage-access-key}
spark.hadoop.fs.s3a.secret.key ${random_password.storage.result}
spark.hadoop.fs.s3a.path.style.access true
spark.hadoop.fs.s3a.impl org.apache.hadoop.fs.s3a.S3AFileSystem
      EOT
  }
}

# "spark.master”,”k8s://https://kubernetes.default" 
# "spark.app.name”, <your_app_name>” 
# "spark.kubernetes.executor.label.<label_name>","<label_value>
# "spark.driver.host”, <the pod's ip address>
# "spark.kubernetes.namespace”, <namespace>
# "spark.submit.deployMode”, “client” 
# "spark.kubernetes.container.image", "<executor image name from above>" 
# "spark.kubernetes.pyspark.pythonVersion”, “3” 
# "spark.driver.port”, “7778” 
# "spark.kubernetes.container.image.pullSecrets", "<secret name>"
# "spark.jars”,”/usr/local/spark/jars/hadoop-aws-2.9.2.jar,/usr/local/spark/jars/aws-java-sdk-1.7.4.jar
# fs.s3a.access.key ****
# fs.s3a.secret.key ****
# fs.s3a.endpoint http://external-storage.storage:9000
# file("${path.module}/spark/master-spark-defaults.conf")

resource "kubernetes_service" "external-spark" {
  depends_on = [module.spark-master, kubernetes_namespace.spark]
  metadata {
    name      = "external-spark"
    namespace = "spark"
    labels = {
      app      = "external-spark"
      resource = "service"
    }
  }
  spec {
    type = "NodePort"
    port {
      port        = 8080
      target_port = 8080
      node_port   = 30080
    }
    selector = {
      app = "spark-master"
    }
  }
}

module "spark-master" {
  depends_on    = [kubernetes_config_map.master-spark-defaults, kubernetes_namespace.spark]
  source        = "../modules/service"
  name          = "spark-master"
  namespace     = "spark"
  image         = "e8kor/spark-py"
  image_version = "3.0.2"
  internal_tcp  = [7077, 8080]
  external_tcp  = [7077]
  command       = ["/opt/spark/bin/spark-class", "org.apache.spark.deploy.master.Master", "--ip", "0.0.0.0", "--port", "7077", "--webui-port", "8080", "--properties-file", "/opt/spark/conf/spark-defaults.conf"]
  replicas      = 1
  cpu           = "100m"
  mounts = [
    {
      claim_name     = "spark-defaults"
      sub_path       = ""
      container_path = "/opt/spark/conf"
    }
  ]
  config_volumes = [
    {
      claim_name      = "spark-defaults"
      config_map_name = "master-spark-defaults"
    }
  ]
  node_selector = {
    "node-role.kubernetes.io/spark" = ""
  }
}

module "spark-worker" {
  depends_on    = [module.spark-master, kubernetes_namespace.spark]
  source        = "../modules/service"
  name          = "spark-worker"
  namespace     = "spark"
  image         = "e8kor/spark-py"
  image_version = "3.0.2"
  internal_tcp  = [8081]
  command       = ["/opt/spark/bin/spark-class", "org.apache.spark.deploy.worker.Worker", "spark://spark-master-tcp-0:7077", "--webui-port", "8081"]
  replicas      = 0
  cpu           = "100m"
  node_selector = {
    "node-role.kubernetes.io/spark" = ""
  }
}
