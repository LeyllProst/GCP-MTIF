# Remote State backend configuration
terraform {
  backend "gcs" {
    bucket = "terraform_remote_state_us-central1_mtif-439912"
    prefix = "terraform/vpc"
  }
}

module "vpc" {
  source = "git@github.com:LeyllProst/gcp-mtif-vpc.git?ref=v1.7.0"

  vpc_network_name = var.vpc_network_name
  ip_cidr_range    = var.ip_cidr_range
}
