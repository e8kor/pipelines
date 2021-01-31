provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "default"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
  debug = true
}

terraform {
  required_version = ">= 0.12"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.0.2"
    }
  }
  backend "kubernetes" {
    secret_suffix    = "state"
    load_config_file = true
  }
}
