# OUTPUTS

output "project_id" {
  value = var.project_id
}

output "region" {
  value = var.region
}

output "main_network_name" {
  value = module.vpc.main_network_name
}

output "subnetworks_name" {
  value = module.vpc.subnetworks_name
}

output "router_name" {
  value = module.vpc.router_name
}

output "private_subnetwork_nat_name" {
  value = module.vpc.private_subnetwork_nat_name
}