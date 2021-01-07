# resource "kubernetes_network_policy" "storage" {
#   # depends_on = [ helm_release.openfaas ]
#   metadata {
#     name = "storage-network-policy"
#     labels = {
#       "app" = "storage"
#     }
#   }

#   spec {
#     pod_selector {
#       match_labels = {
#         "app" = "storage"
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