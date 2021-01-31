resource "helm_release" "openfaas" {
  name             = "openfaas"
  namespace        = "openfaas"
  create_namespace = true

  repository = "https://openfaas.github.io/faas-netes"
  chart      = "openfaas"

  values = [
    file("${path.module}/faas/values-arm64.yaml")
  ]
}

resource "helm_release" "openfaas-nats-connector" {
  depends_on       = [helm_release.openfaas]
  name             = "nats-connector"
  namespace        = "openfaas"
  repository       = "https://openfaas.github.io/faas-netes"
  chart            = "nats-connector"
  create_namespace = true
  values = [
    file("${path.module}/faas/values-nats.yaml")
  ]
}

resource "helm_release" "openfaas-cron-connector" {
  depends_on = [helm_release.openfaas]
  name       = "cron-connector"
  namespace  = "openfaas"

  repository       = "https://openfaas.github.io/faas-netes"
  chart            = "cron-connector"
  create_namespace = true
  values = [
    file("${path.module}/faas/values-cron.yaml")
  ]
}
