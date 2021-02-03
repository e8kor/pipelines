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

resource "kubernetes_namespace" "airflow" {
  metadata {
    labels = {
      app      = "airflow"
      resource = "namespace"
    }

    name = "airflow"
  }
}
resource "kubernetes_namespace" "storage" {
  metadata {
    labels = {
      app      = "storage"
      resource = "namespace"
    }

    name = "storage"
  }
}

resource "kubernetes_namespace" "database" {
  metadata {
    labels = {
      app      = "database"
      resource = "namespace"
    }

    name = "database"
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