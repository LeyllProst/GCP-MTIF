# OUTPUTS

output "main_network_name" {
  value = google_compute_network.this.name
}

output "subnetworks_name" {
  value = google_compute_subnetwork.this[*].name
}

output "router_name" {
  value = google_compute_router.this.name
}

output "private_subnetwork_nat_name" {
  value = google_compute_router_nat.this.name
}