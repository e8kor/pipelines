provider "kubernetes-alpha" {
  server_side_planning = true
  config_path          = "~/.kube/config"
}

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
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.0.1"
    }
    kubernetes-alpha = {
      source  = "hashicorp/kubernetes-alpha"
      version = "0.2.1"
    }
  }
  backend "kubernetes" {
    secret_suffix    = "state"
    load_config_file = true
  }
}
