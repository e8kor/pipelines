resource "kubernetes_storage_class" "cstor" {
  depends_on          = [null_resource.cstor-pool-claim]
  storage_provisioner = "openebs.io/provisioner-iscsi"

  metadata {
    name = "openebs-sc-statefulset"
    annotations = {
      "cas.openebs.io/config" = <<-EOT
      - name: StoragePoolClaim
        value: "cstor-disk-pool"
      - name: ReplicaCount
        value: "1"
      EOT
      "openebs.io/cas-type"   = "cstor"
    }
  }
}
