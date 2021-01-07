resource "helm_release" "openfaas" {
  name      = "openfaas"
  namespace = "openfaas"

  repository = "https://openfaas.github.io/faas-netes"
  chart      = "openfaas/openfaas"

  set {
    name  = "functionNamespace"
    value = "openfaas-fn"
  }

  set {
    name  = "generateBasicAuth"
    value = true
  }
}
resource "helm_release" "openfaas_nats_connector" {
  name      = "nats-connector"
  namespace = "openfaas"
  # UPDATE image to this ghcr.io/openfaas/nats-connector
  repository = "https://openfaas.github.io/faas-netes"
  chart      = "openfaas/nats-connector"
}

resource "helm_release" "openfaas_cron_connector" {
  name      = "cron-connector"
  namespace = "openfaas"

  repository = "https://openfaas.github.io/faas-netes"
  chart      = "openfaas/cron-connector"
}
