# resource "kubernetes_ingress" "ingress" {
#   metadata {
#     name = var.name
#     labels = {
#       "app" = var.name
#     }
#   }

#   spec {
#     dynamic "rule" {
#       for_each = var.internal_tcp
#       content {
#         host = var.name
#         http {
#           path {
#             backend {
#               service_name = "${var.name}-service"
#               service_port = rule.value
#             }
#           }
#         }
#       }
#     }
#   }
# }
