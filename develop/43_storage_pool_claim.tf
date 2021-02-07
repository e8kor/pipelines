resource "null_resource" "cstor-pool-claim" {
  provisioner "local-exec" {
    command = "kubectl apply -f - <<EOF\n${var.storage-pool-claim}\nEOF"
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "kubectl delete -f - <<EOF\n${var.storage-pool-claim}\nEOF"
  }
}

variable "storage-pool-claim" {
  default = <<EOF
    apiVersion: openebs.io/v1alpha1
    kind: StoragePoolClaim
    metadata:
    name: cstor-disk-pool
    annotations:
        cas.openebs.io/config: |
        - name: PoolResourceRequests
            value: |-
                memory: 2Gi
        - name: PoolResourceLimits
            value: |-
                memory: 4Gi
    spec:
    name: cstor-disk-pool
    type: disk
    poolSpec:
        poolType: striped
    blockDevices:
        blockDeviceList:
        - blockdevice-68f6608e90a4f7aa9572d8a6b3390b22
        - blockdevice-3b03edcb1c311a1cf9c9ec248a39ff6d
        - blockdevice-19d677c3aee4f7d9785e7052579e3c53
        - blockdevice-6b06cab63269f72f791eaf3e00db45ad
        - blockdevice-cbd63357634af1aa2c2cd05f86d5e8a9
        - blockdevice-03a8e056ca2f4fefff8cff8afafaf442
    EOF
}