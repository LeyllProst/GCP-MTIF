output "project" {
  value = google_storage_bucket.terraform_state.project
}

output "location" {
  value = google_storage_bucket.terraform_state.location
}

output "vpc_network_name" {
  value = module.vpc.vpc_network_name
}

output "vpc_network_self_link" {
  value = module.vpc.vpc_network_self_link
}
output "vpc_subnetwork_name" {
  value = module.vpc.vpc_subnetwork_name
}

output "vpc_subnetwork_self_link" {
  value = module.vpc.vpc_subnetwork_self_link
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
