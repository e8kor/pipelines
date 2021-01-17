resource "helm_release" "openfaas" {
  depends_on = [kubernetes_namespace.openfaas-fn]
  name       = "openfaas"
  namespace  = "openfaas"

  repository = "https://openfaas.github.io/faas-netes"
  chart      = "openfaas"

  set {
    name  = "functionNamespace"
    value = "openfaas-fn"
  }

  set {
    name  = "generateBasicAuth"
    value = true
  }
}

resource "helm_release" "openfaas-nats-connector" {
  depends_on = [helm_release.openfaas]
  name       = "nats-connector"
  namespace  = "openfaas"
  # UPDATE image to this ghcr.io/openfaas/nats-connector
  repository = "https://openfaas.github.io/faas-netes"
  chart      = "nats-connector"
}

resource "helm_release" "openfaas-cron-connector" {
  depends_on = [helm_release.openfaas]
  name       = "cron-connector"
  namespace  = "openfaas"

  repository = "https://openfaas.github.io/faas-netes"
  chart      = "cron-connector"
}
