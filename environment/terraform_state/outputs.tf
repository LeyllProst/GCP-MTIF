output "project_id" {
  value = var.project_id
}

output "remote_state_location" {
  value = var.bucket_location
}

output "remote_state_name" {
  value = google_storage_bucket.terraform_remote_state.name
}
