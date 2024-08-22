terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.51.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.15.0"
    }
  }
}

provider "google" {
  project = var.project_id
}

provider "helm" {
  kubernetes {
    config_path = var.kube_config_path
  }
}
