terraform {
  required_version = ">= 0.12"
  backend "kubernetes" {
    secret_suffix    = "state"
    load_config_file = true
  }
}
