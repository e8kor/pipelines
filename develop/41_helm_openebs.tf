resource "helm_release" "openebs" {
  name      = "openebs"
  namespace = "openebs"

  repository = "https://openebs.github.io/charts"
  chart      = "openebs"

  values = [
    file("${path.module}/openebs/values.yaml")
  ]
}
