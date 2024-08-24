### ArgoCDPlayground

---

Core infrastructure is configure under `/terraform` 
- network, underlying compute for ArgoCD and additional configuration to standup the base platform
- each layer can be applied with the following command
  - `terraform init`
  - `terraform worspace [new | select] dev`
  - `terraform apply -var-file z-dev.tfvars` 

All application level infra can be configured under `/argo`
- resource under argo can be deployed via GitOps strategy (argocd listen for changes and syncs state)
