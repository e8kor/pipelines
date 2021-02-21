resource "helm_release" "openfaas" {
  name      = "openfaas"
  namespace = "openfaas"

  repository = "https://openfaas.github.io/faas-netes"
  chart      = "openfaas"
  version    = "7.0.4"
  create_namespace = true

  values = [
    file("${path.module}/helm_openfaas/values-arm64.yaml")
  ]
}

resource "helm_release" "openfaas-nats-connector" {
  depends_on = [helm_release.openfaas]
  name       = "nats-connector"
  namespace  = "openfaas"

  repository = "https://openfaas.github.io/faas-netes"
  chart      = "nats-connector"
  version    = "0.1.0"

  values = [
    file("${path.module}/helm_openfaas/values-nats.yaml")
  ]
}

resource "helm_release" "openfaas-cron-connector" {
  depends_on = [helm_release.openfaas]
  name       = "cron-connector"
  namespace  = "openfaas"

  repository = "https://openfaas.github.io/faas-netes"
  chart      = "cron-connector"
  version    = "0.3.2"

  values = [
    file("${path.module}/helm_openfaas/values-cron.yaml")
  ]
}
