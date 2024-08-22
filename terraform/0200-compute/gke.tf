data "google_container_engine_versions" "gke_version" {
  location = var.region
  version_prefix = "1.29."
}

resource "google_container_cluster" "primary" {
  name     = "${var.project_id}-gke"
  location = var.region

  enable_autopilot = true
  networking_mode  = "VPC_NATIVE"

  ip_allocation_policy {
    // Set to blank to have a range chosen with the default size.
    cluster_ipv4_cidr_block = ""
  }

  network    = var.vpc_name
  subnetwork = var.subnet_name
}

