# resource "kubernetes_network_policy" "database" {
#   # depends_on = [ helm_release.openfaas ]
#   metadata {
#     name = "database-network-policy"
#     labels = {
#       "app" = "database"
#     }
#   }

#   spec {
#     pod_selector {
#       match_labels = {
#         "app" = "database"
#       }
#     }

#     ingress {
#       from {
#         namespace_selector {
#           match_labels = {
#             "app" = "function"
#           }
#         }
#       }
#     }
#     policy_types = ["Ingress"]
#   }
# }