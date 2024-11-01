provider "google" {
  project = var.project_id
  region  = var.region
}

data "google_compute_zones" "this" {
  region  = var.region
  project = var.project_id
}

locals {
  type  = ["public", "private"]
  zones = data.google_compute_zones.this.names
}

resource "google_compute_network" "this" {
  name                            = "${var.main_network_name}"
  delete_default_routes_on_create = false
  auto_create_subnetworks         = false
  routing_mode                    = "REGIONAL"
}
