resource "helm_release" "cross_plane" {
  name             = "crossplane"
  chart            = "crossplane"
  repository       = "https://charts.crossplane.io/stable"
  create_namespace = true
  namespace        = "crossplane-system"
}

resource "kubectl_manifest" "gcp_provider" {
  yaml_body = <<YAML
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-gcp-storage
spec:
  package: xpkg.upbound.io/upbound/provider-gcp-storage:v0.40.0
YAML
}

resource "kubectl_manifest" "gcp_provider_config" {
  yaml_body = <<YAML
apiVersion: gcp.upbound.io/v1beta1
kind: ProviderConfig
metadata:
  name: default
spec:
  projectID: ${var.project_id}
  credentials:
    source: Secret
    secretRef:
      namespace: crossplane-system
      name: gcp-secret
      key: creds
YAML
}
