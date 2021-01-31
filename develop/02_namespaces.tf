resource "kubernetes_namespace" "openfaas-fn" {
  metadata {
    labels = {
      app      = "openfaas-fn"
      resource = "namespace"
    }

    name = "openfaas-fn"
  }
}
resource "kubernetes_namespace" "openfaas" {
  metadata {
    labels = {
      app      = "openfaas"
      resource = "namespace"
    }

    name = "openfaas"
  }
}

resource "kubernetes_namespace" "openebs" {
  metadata {
    labels = {
      app      = "openebs"
      resource = "namespace"
    }

    name = "openebs"
  }
}