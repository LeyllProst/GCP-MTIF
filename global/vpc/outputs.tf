output "project" {
  value = google_storage_bucket.terraform_state.project
}

output "location" {
  value = google_storage_bucket.terraform_state.location
}

output "main_network_name" {
  value = module.vpc.main_network_name
}

output "subnetworks_name" {
  value = module.vpc.subnetworks_name
}
