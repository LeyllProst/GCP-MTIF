data "google_compute_zones" "this" {
  region = var.region
}

locals {
  type  = ["public", "private"]
  zones = data.google_compute_zones.this.names
}

# NETWORK
resource "google_compute_network" "this" {
  name                            = var.main_network_name
  delete_default_routes_on_create = false
  auto_create_subnetworks         = false
  routing_mode                    = "REGIONAL"
}

# SUBNETS
resource "google_compute_subnetwork" "this" {
  count                    = 2
  name                     = "${var.main_network_name}-${local.type[count.index]}-subnetwork"
  ip_cidr_range            = var.ip_cidr_range[count.index]
  region                   = var.region
  project                  = var.project_id
  network                  = google_compute_network.this.id
  private_ip_google_access = true
}

# NAT ROUTER
resource "google_compute_router" "this" {
  name    = "${var.main_network_name}-${local.type[1]}-router"
  region  = google_compute_subnetwork.this[1].region
  network = google_compute_network.this.id
}

resource "google_compute_router_nat" "this" {
  name                               = "${var.main_network_name}-${local.type[1]}-router-nat"
  router                             = google_compute_router.this.name
  region                             = google_compute_router.this.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = "${var.main_network_name}-${local.type[1]}-subnetwork"
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}