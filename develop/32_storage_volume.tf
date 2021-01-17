# resource "kubernetes_persistent_volume" "storage-0" {
#   metadata {
#     name = "storage-0"
#     labels = {
#       app      = "storage"
#       resource = "volume"
#     }
#   }

#   spec {
#     capacity = {
#       storage = "1Gi"
#     }
#     storage_class_name               = "standard"
#     access_modes                     = ["ReadWriteMany", "ReadWriteOnce"]
#     persistent_volume_reclaim_policy = "Retain"
#     persistent_volume_source {
#       host_path {
#         path = "/mnt/storage"
#       }
#     }
#   }
# }
# resource "kubernetes_persistent_volume" "storage-1" {
#   metadata {
#     name = "storage-1"
#     labels = {
#       "app"    = "storage"
#       resource = "volume"
#     }
#   }

#   spec {
#     capacity = {
#       storage = "1Gi"
#     }
#     storage_class_name               = "standard"
#     access_modes                     = ["ReadWriteMany", "ReadWriteOnce"]
#     persistent_volume_reclaim_policy = "Retain"
#     persistent_volume_source {
#       host_path {
#         path = "/mnt/storage"
#       }
#     }
#   }
# }

# resource "kubernetes_persistent_volume" "storage-2" {
#   metadata {
#     name = "storage-2"
#     labels = {
#       app      = "storage"
#       resource = "volume"
#     }
#   }
#   spec {
#     capacity = {
#       storage = "1Gi"
#     }
#     storage_class_name               = "standard"
#     access_modes                     = ["ReadWriteMany", "ReadWriteOnce"]
#     persistent_volume_reclaim_policy = "Retain"
#     persistent_volume_source {
#       host_path {
#         path = "/mnt/storage"
#       }
#     }
#   }
# }

# resource "kubernetes_persistent_volume" "storage-3" {
#   metadata {
#     name = "storage-3"
#     labels = {
#       app      = "storage"
#       resource = "volume"
#     }
#   }
#   spec {
#     capacity = {
#       storage = "1Gi"
#     }
#     storage_class_name               = "standard"
#     access_modes                     = ["ReadWriteMany", "ReadWriteOnce"]
#     persistent_volume_reclaim_policy = "Retain"
#     persistent_volume_source {
#       host_path {
#         path = "/mnt/storage"
#       }
#     }
#   }
# }