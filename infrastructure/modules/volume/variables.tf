variable "name" {
  description = "The name of the service"
  type        = string
}

variable "storage" {
  default = null
}

variable "storage_path" {
  default = "/mnt"
}
