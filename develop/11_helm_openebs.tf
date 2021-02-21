resource "helm_release" "openebs" {
  # depends_on = [kubernetes_namespace.openebs]
  name       = "openebs"
  repository = "https://openebs.github.io/charts"
  chart      = "openebs"
  version    = "2.5.0"

  namespace        = "openebs"
  create_namespace = true

  values = [
    file("${path.module}/helm_openebs/values.yaml")
  ]
}
