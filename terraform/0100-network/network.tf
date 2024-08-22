resource "google_compute_network" "vpc_network" {
  name                    = "${var.environment}-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "default" {
  name          = "${var.environment}-${var.region}-subnet"
  ip_cidr_range = var.cidr
  region        = var.region
  network       = google_compute_network.vpc_network.id
}
