# resource "kubernetes_storage_class" "cstor-storageclass" {
#   metadata {
#     name = "cstor-storageclass"
#     annotations = {    
#       "openebs.io/cas-type" = "cstor"
#       "cas.openebs.io/config" = <<-CONF
#         - name: StoragePoolClaim
#           value: "cStorPool-SSD" = "cstor-disk-pool"
#         - name: ReplicaCount
#           value: "3"
#         - name: FSType
#           value: ext4
#       CONF
#     }
#   }
#   storage_provisioner = "openebs.io/provisioner-iscsi"
# }