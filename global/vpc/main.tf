resource "google_storage_bucket" "terraform_state" {
  name                        = "terraform-state-us-central1-mtif-439912"
  project                     = var.project_id
  location                    = var.region
  uniform_bucket_level_access = true
  force_destroy               = true
  storage_class               = "STANDARD"
  versioning {
    enabled = true
  }
}

terraform {
  backend "gcs" {
    bucket = "terraform-state-us-central1-mtif-439912"
    prefix = "terraform/state"
  }
}

module "vpc" {
  source = "git@github.com:LeyllProst/gcp-mtif-vpc.git?ref=b/1.6.1"

  network_name  = var.network_name
  ip_cidr_range = var.ip_cidr_range
}
