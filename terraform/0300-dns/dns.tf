data "kubernetes_service" "argo_cd_server" {
  metadata {
    namespace = "argocd"
    name      = "argocd-server"
  }
}

resource "cloudflare_record" "argo_cd_record" {
  name    = "${var.environment}-argo"
  type    = "A"
  proxied = true
  zone_id = var.cloudflare_zone_id
  content = data.kubernetes_service.argo_cd_server.status[0].load_balancer[0].ingress[0].ip
}
