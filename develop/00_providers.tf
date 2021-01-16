provider "kubernetes" {
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}


terraform {
  required_version = ">= 0.12"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.0.1"
    }
  }
  backend "kubernetes" {
    secret_suffix    = "state"
    load_config_file = true
  }
}
