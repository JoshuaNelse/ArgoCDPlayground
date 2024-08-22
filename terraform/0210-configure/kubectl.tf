data "http" "argo_cd_manifest" {
  url = "https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml"
}

data "kubectl_file_documents" "argo_cd_doc" {
  content = data.http.argo_cd_manifest.response_body
}

resource "kubectl_manifest" "argo_cd" {
  for_each           = toset(data.kubectl_file_documents.argo_cd_doc.documents)
  yaml_body          = each.value
  override_namespace = kubernetes_namespace.argo_cd_namespace.metadata[0].name
}
