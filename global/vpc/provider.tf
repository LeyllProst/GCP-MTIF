data "terraform_remote_state" "vpc" {
  backend = "gcs"

  config = {
    bucket = "terraform-state-us-central1-mtif-439912"
    prefix = "terraform/state"
  }
}

# Configure the Google Cloud Provider
terraform {
  required_version = ">=1.11.4"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.33.0"
    }
  }
}

provider "google" {
  project = data.terraform_remote_state.vpc.outputs.project
  region  = data.terraform_remote_state.vpc.outputs.location
}