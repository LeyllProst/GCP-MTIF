output "project_id" {
  value = var.project_id
}

output "region" {
  value = var.project_id
}

output "main_network_name" {
  value = module.vpc.main_network_name
}

output "subnetworks_name" {
  value = module.vpc.subnetworks_name
}
