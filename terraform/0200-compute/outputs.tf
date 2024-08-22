output "region" {
  value = var.region
}

output "kubernetes_cluster_name" {
  value = google_container_cluster.primary.name
}

output "gke_cluster_endpoint" {
  value = google_container_cluster.primary.endpoint
}

output "gke_cluster_ca_cert" {
  value = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
}

