variable "storage-access-key" {
  type    = string
  default = "minio"
}

resource "random_password" "storage" {
  length           = 16
  special          = true
  override_special = "_%@"
}

output "storage-access-key" {
  value = var.storage-access-key
}

output "storage-secret-key" {
  value     = random_password.storage.result
  sensitive = true
}
