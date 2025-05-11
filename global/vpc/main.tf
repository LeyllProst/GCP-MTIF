resource "google_storage_bucket" "terraform_state" {
  name                        = "terraform-state-us-central1-mtif-439912"
  location                    = "us-central1"
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
  source = "git@github.com:LeyllProst/gcp-mtif-vpc.git?ref=v1.6.0"

  project_id = var.project_id
  region     = var.region
}
