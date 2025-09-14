# Remote State backend configuration
terraform {
  backend "gcs" {
    bucket = "terraform_remote_state_us-central1_mtif-439912"
    prefix = "terraform/monitoring"
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


# MONITORING instance
module "monitoring" {
  source = "git@github.com:LeyllProst/gcp-mtif-instances.git?ref=v2.1.2"

  project_id = data.terraform_remote_state.trs.outputs.project_id
  network    = data.terraform_remote_state.vpc.outputs.vpc_network_self_link
  subnetwork = data.terraform_remote_state.vpc.outputs.vpc_subnetwork_self_link[0]

  instance_name                = var.monitoring_instance_name
  zone                         = var.monitoring_instance_zone
  network_ip                   = var.monitoring_network_ip
  instance_type                = var.monitoring_instance_type
  update_stopping              = var.monitoring_update_stopping
  deletion_protection          = var.monitoring_deletion_protection
  labels                       = var.monitoring_instance_labels
  bootdisk_image_size          = var.monitoring_bootdisk_image_size
  image                        = var.monitoring_image
  startup_script               = var.monitoring_startup_script
  assign_ephemeral_external_ip = var.monitoring_assign_ephemeral_external_ip
  tags                         = [var.monitoring_instance_name]
}


# FIREWALL rules
module "monitoring_firewall" {
  source = "git@github.com:LeyllProst/gcp-mtif-firewall.git?ref=v2.1.0"

  project = data.terraform_remote_state.trs.outputs.project_id

  firewall_name = "monitoring-firewall-rules"
  network       = data.terraform_remote_state.vpc.outputs.vpc_network_self_link
  source_ranges = ["0.0.0.0/0"]
  target_tags   = [var.monitoring_instance_name]

  allow_rules = [
    {
      protocol = "tcp"
      ports    = ["8080"]
    }
  ]
}
