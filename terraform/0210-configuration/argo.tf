data "http" "argo_cd_manifest" {
  url = "https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml"
}

data "kubectl_file_documents" "argo_cd_doc" {
  content = data.http.argo_cd_manifest.response_body
}

resource "kubectl_manifest" "argo_cd" {
  count              = length(data.kubectl_file_documents.argo_cd_doc.documents)
  yaml_body          = data.kubectl_file_documents.argo_cd_doc.documents[count.index]
  override_namespace = kubernetes_namespace.argo_cd_namespace.metadata[0].name
}

resource "kubectl_manifest" "service" {
  yaml_body = <<YAML
apiVersion: v1
kind: Service
metadata:
  labels:
    app.kubernetes.io/component: server
    app.kubernetes.io/name: argocd-server
    app.kubernetes.io/part-of: argocd
  name: argocd-server
spec:
  type: LoadBalancer
  ports:
  - name: http
    port: 80
    protocol: TCP
    targetPort: 8080
  - name: https
    port: 443
    protocol: TCP
    targetPort: 8080
  selector:
    app.kubernetes.io/name: argocd-server
YAML
}

resource "kubectl_manifest" "repo" {
  yaml_body = <<YAML
apiVersion: v1
kind: Secret
metadata:
  name: private-repo
  namespace: argocd
  labels:
    argocd.argoproj.io/secret-type: repository
stringData:
  type: git
  url: ${var.argo_core_repo}
YAML
}

resource "kubectl_manifest" "application" {
  override_namespace = "argocd"
  yaml_body = <<YAML
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: learning
  namespace: argocd
spec:
  project: default
  source:
    repoURL: ${var.argo_core_repo}
    targetRevision: HEAD
    path: argo/bucket
  destination:
    server: https://kubernetes.default.svc
    namespace: argocd
YAML
}
