# resource "kubernetes_ingress" "ingress" {
#   depends_on = [module.storage]
#   metadata {
#     name = "storage"
#     labels = {
#       "app" = "storage"
#     }
#   }

#   spec {
#     rule {
#       http {
#         path {
#           backend {
#             service_name = "storage-service"
#             service_port = 9000
#           }
#         }
#       }
#     }
#   }
# }