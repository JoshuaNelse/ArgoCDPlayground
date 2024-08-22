resource "helm_release" "cross_plane" {
  name             = "crossplane"
  chart            = "crossplane"
  repository       = "https://charts.crossplane.io/stable"
  create_namespace = true
  namespace        = "crossplane-system"
}
