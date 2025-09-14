data "terraform_remote_state" "trs" {
  backend = "gcs"

  config = {
    bucket = "terraform_remote_state_us-central1_mtif-439912"
    prefix = "terraform/remote-state"
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
  project = data.terraform_remote_state.trs.outputs.project_id
  region  = data.terraform_remote_state.trs.outputs.remote_state_location
}
