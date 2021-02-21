resource "kubernetes_namespace" "openfaas-fn" {
  metadata {
    labels = {
      app      = "openfaas-fn"
      resource = "namespace"
    }

    name = "openfaas-fn"
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

resource "kubernetes_namespace" "spark" {
  metadata {
    labels = {
      app      = "spark"
      resource = "namespace"
    }

    name = "spark"
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
