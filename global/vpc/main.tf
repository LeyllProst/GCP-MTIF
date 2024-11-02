provider "google" {
  project = var.project_id
  region  = var.region
}

module "vpc" {
  source = "../../modules/vpc"

  region     = var.region
  project_id = var.project_id
}
