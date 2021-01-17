# resource "kubernetes_persistent_volume" "database-0" {
#   metadata {
#     name = "database-0"
#     labels = {
#       app      = "database"
#       resource = "volume"
#     }
#   }
#   spec {
#     capacity = {
#       storage = "2Gi"
#     }
#     storage_class_name               = "standard"
#     access_modes                     = ["ReadWriteMany", "ReadWriteOnce"]
#     persistent_volume_reclaim_policy = "Retain"
#     persistent_volume_source {
#       host_path {
#         path = "/mnt/database"
#       }
#     }
#   }
# }