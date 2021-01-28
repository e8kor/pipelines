resource "kubernetes_secret" "fs-provisioner" {
  metadata {
    name = "fs-provisioner"
  }

  data = {
    username = "admin"
    secret = "ivd7dfORN7QNeKVO"
  }
}

resource "kubernetes_secret" "fs-db-secret" {
  metadata {
    name = "fs-db-secret"
    labels = {
      glusterfs = "heketi-db"
      heketi = "db"
    }
  }

  data = {}
}

resource "kubernetes_config_map" "fs-provisioner-topology-config" {
  metadata {
    name = "fs-provisioner-topology-config"
    labels = {
      app      = "fs-provisioner-topology-config"
      resource = "config"
    }
  }

  data = {
    "default.json"  = file("${path.module}/glusterfs/heketi-topology.json")
  }
}

resource "kubernetes_config_map" "fs-provisioner-config" {
  metadata {
    name = "fs-provisioner-config"
    labels = {
      app      = "fs-provisioner-config"
      resource = "config"
    }
  }

  data = {
    "heketi.json"  = file("${path.module}/glusterfs/heketi-config.json")
  }
}

resource "kubernetes_service" "fs-provisioner" {
  metadata {
    name = "fs-provisioner"
    labels = {
      app      = "fs-provisioner"
      resource = "service"
      glusterfs= "heketi-service"
      deploy-heketi = "support"
    }
  }
  spec {
    selector = {
      app      = "fs-provisioner"
      resource = "pod"
    }

    port {
      name        = "fs-provisioner"
      port        = 8080
      target_port = 8080
    }
  }
} 

resource "kubernetes_service" "fs-provisioner" {
  metadata {
    name = "fs-provisioner"
    labels = {
      app      = "fs-provisioner"
      resource = "service"
      glusterfs= "heketi-service"
      deploy-heketi = "support"
    }
  }
  spec {
    selector = {
      app      = "fs-provisioner"
      resource = "pod"
    }

    port {
      name        = "fs-provisioner"
      port        = 8080
      target_port = 8080
    }
  }
} 
# {
#       "kind": "Service",
#       "apiVersion": "v1",
#       "metadata": {
#         "name": "heketi",
#         "labels": {
#           "glusterfs": "heketi-service",
#           "deploy-heketi": "support"
#         },
#         "annotations": {
#           "description": "Exposes Heketi Service"
#         }
#       },
#       "spec": {
#         "selector": {
#           "name": "heketi"
#         },
#         "ports": [
#           {
#             "name": "heketi",
#             "port": 8080,
#             "targetPort": 8080
#           }
#         ]
#       }
#     } 
resource "kubernetes_service" "fs-provisioner" {
  metadata {
    name = "fs-provisioner"
    labels = {
      app      = "fs-provisioner"
      resource = "service"
      glusterfs= "heketi-service"
      deploy-heketi = "support"
    }
  }
  spec {
    selector = {
      app      = "fs-provisioner"
      resource = "pod"
    }

    port {
      name        = "fs-provisioner"
      port        = 8080
      target_port = 8080
    }
  }
} 

# {
#       "kind": "Service",
#       "apiVersion": "v1",
#       "metadata": {
#         "name": "deploy-heketi",
#         "labels": {
#           "glusterfs": "heketi-service",
#           "deploy-heketi": "support"
#         },
#         "annotations": {
#           "description": "Exposes Heketi Service"
#         }
#       },
#       "spec": {
#         "selector": {
#           "name": "deploy-heketi"
#         },
#         "ports": [
#           {
#             "name": "deploy-heketi",
#             "port": 8080,
#             "targetPort": 8080
#           }
#         ]
#       }
#     }