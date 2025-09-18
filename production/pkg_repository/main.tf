# Remote State backend configuration
terraform {
  backend "gcs" {
    bucket = "terraform_remote_state_us-central1_mtif-439912"
    prefix = "terraform/pkg-repository"
  }
}

# REMOTE STATE reading from gcs
data "terraform_remote_state" "trs" {
  backend = "gcs"

  config = {
    bucket = "terraform_remote_state_us-central1_mtif-439912"
    prefix = "terraform/remote-state"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "gcs"

  config = {
    bucket = "terraform_remote_state_us-central1_mtif-439912"
    prefix = "terraform/vpc"
  }
}

# PKG REPOSITORY instance
module "pkg_repository" {
  source = "git@github.com:LeyllProst/gcp-mtif-instances.git?ref=v2.0.2"

  project_id          = data.terraform_remote_state.trs.outputs.project_id
  network             = data.terraform_remote_state.vpc.outputs.vpc_network_self_link
  subnetwork          = data.terraform_remote_state.vpc.outputs.vpc_subnetwork_self_link[1]
  instance_name       = var.pkg_repository_instance_name
  zone                = var.pkg_repository_instance_zone
  instance_type       = var.pkg_repository_instance_type
  update_stopping     = var.update_stopping
  deletion_protection = var.deletion_protection
  labels              = var.pkg_repository_labels

  bootdisk_image_size = var.pkg_repository_bootdisk_image_size
  image               = var.pkg_repository_image

  startup_script = var.pkg_repository_startup_script
}