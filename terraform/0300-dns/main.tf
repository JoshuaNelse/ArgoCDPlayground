terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.51.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.32.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  project = var.project_id
}

provider "kubernetes" {
  config_path = var.kube_config_path
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
