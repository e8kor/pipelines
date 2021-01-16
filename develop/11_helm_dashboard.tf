resource "helm_release" "dashboard" {
  name      = "dashboard"
  namespace = "kubernetes-dashboard"

  repository = "https://kubernetes.github.io/dashboard"
  chart      = "kubernetes-dashboard"

}