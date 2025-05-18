output "project" {
  value = google_storage_bucket.terraform_state.project
}

output "location" {
  value = google_storage_bucket.terraform_state.location
}

output "network_name" {
  value = module.vpc.network_name
}
output "subnetworks_name" {
  value = module.vpc.subnetworks
}

output "ip_cidr_range" {
  value = module.vpc.ip_cidr_range
}

output "firewall_name" {
  value = module.vpc.firewall_name
}

output "nat_ip_addresses" {
  value = module.vpc.nat_ips
}
