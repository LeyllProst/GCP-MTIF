resource "google_storage_bucket" "terraform_state" {
  name                        = "terraform-state-us-central1-mtif-439912"
  project                     = var.project
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

# module "vpc" {
#   source = "git@github.com:LeyllProst/gcp-mtif-vpc.git?ref=b/1.6.1"


#   # project_id    = var.project
#   # region        = var.region
#   # ip_cidr_range = ["10.10.10.0/24", "10.10.20.0/24"]
# }
