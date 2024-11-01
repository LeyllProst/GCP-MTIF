# OUTPUTS

output "A-project_id" {
  value = var.project_id
}

output "B-region" {
  value = var.region
}

output "C-main_network_name" {
  value = module.vpc.main_network_name
}

output "D-subnetworks_name" {
  value = module.vpc.subnetworks_name
}

output "E-router_name" {
  value = module.vpc.router_name
}

output "F-private_subnetwork_nat_name" {
  value = module.vpc.private_subnetwork_nat_name
}