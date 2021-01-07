variable "name" {
  description = "The name of the service"
  type        = string
}

variable "image" {
  description = "The docker image name to use within this service"
  type        = string
}

variable "image_version" {
  description = "The image verison to use"
  type        = string
  default     = "latest"
}

variable "env" {
  description = "Environment variables to be passed into the tasks"
  default     = {}
}

variable "args" {
  description = "Application arguments"
  default     = null
  type        = list(string)
}

variable "replicas" {
  description = "Override for scaling how many containers should exist for this service"
  default     = 1
}

variable "command" {
  description = "Application command"
  default     = null
  type        = list(string)
}

variable "public" {
  default = false
}

variable "internal_tcp" {
  description = "UDP Ports to forward"
  default     = []
  type        = list(number)
}

variable "external_tcp" {
  description = "TCP ports to proxy"
  default     = []
  type        = list(number)
}

variable "storage" {
  default = null
}

variable "storage_path" {
  default = "/mnt"
}

variable "mounts" {
  type = list(object({
    claim_name     = string
    sub_path       = string
    container_path = string
  }))
}

variable "memory" {
  description = "how much memory the application needs"
  default     = null
}

variable "cpu" {
  description = "how much cpu the application needs"
  default     = null
}
