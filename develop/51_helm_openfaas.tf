resource "helm_release" "openfaas" {
  name             = "openfaas"
  namespace        = "openfaas"
  create_namespace = true

  repository = "https://openfaas.github.io/faas-netes"
  chart      = "openfaas"

  values = [
    file("${path.module}/faas/values.yaml")
  ]
}

resource "helm_release" "openfaas-nats-connector" {
  depends_on = [helm_release.openfaas]
  name       = "nats-connector"
  namespace  = "openfaas"
  # UPDATE image to this ghcr.io/openfaas/nats-connector
  repository       = "https://openfaas.github.io/faas-netes"
  chart            = "nats-connector"
  create_namespace = true
}

resource "helm_release" "openfaas-cron-connector" {
  depends_on = [helm_release.openfaas]
  name       = "cron-connector"
  namespace  = "openfaas"

  repository       = "https://openfaas.github.io/faas-netes"
  chart            = "cron-connector"
  create_namespace = true
}
