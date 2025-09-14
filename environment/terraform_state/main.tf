# BUCKET for Terraform Remote State
resource "google_storage_bucket" "terraform_remote_state" {
  name                        = "terraform_remote_state_${var.bucket_location}_${var.project_id}"
  project                     = var.project_id
  location                    = var.bucket_location
  uniform_bucket_level_access = true
  force_destroy               = false
  storage_class               = "STANDARD"
  
  versioning {
    enabled = true
  }
}

# Remote State backend configuration
terraform {
  backend "gcs" {
    bucket = "terraform_remote_state_us-central1_mtif-439912"
    prefix = "terraform/remote-state"
  }
}
