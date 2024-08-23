resource "kubernetes_namespace" "argo_cd_namespace" {
  metadata {
    name = "argocd"
  }
}
