# resource "kubernetes_service" "external-kubernetes-dashboard" {
#   metadata {
#     name = "external-kubernetes-dashboard"
#     namespace = "kubernetes-dashboard"
#     labels = {
#       k8s-app = "kubernetes-dashboard"
#     }
#   }
#   spec {
#     type = "LoadBalancer"
#     session_affinity = "ClientIP" 
#     selector = {
#       "k8s-app" = "kubernetes-dashboard"
#     }

#     port {
#       name = "access-port"
#       protocol = "TCP"
#       port = 8001
#       target_port = 8443
#     }
#   }
  
# }