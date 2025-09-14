# REMOTE STATE reading from gcs
data "terraform_remote_state" "vpc" {
  backend = "gcs"

  config = {
    bucket = "terraform-state-us-central1-mtif-439912"
    prefix = "terraform/state"
  }
}


# MONITORING instance
module "monitoring" {
  source = "git@github.com:LeyllProst/gcp-mtif-instances.git?ref=v2.1.2"

  project_id = data.terraform_remote_state.vpc.output.project
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
# module "monitoring_firewall" {
#   source = "git@github.com:LeyllProst/gcp-mtif-firewall.git?ref=v2.1.0"

#   project = data.terraform_remote_state.vpc.outputs.project

#   firewall_name = "monitoring-firewall-rules"
#   network       = data.terraform_remote_state.vpc.outputs.vpc_network_self_link
#   source_ranges = ["0.0.0.0/0"]
#   target_tags   = [var.monitoring_instance_name]

#   allow_rules = [
#     {
#       protocol = "tcp"
#       ports    = ["8080"]
#     }
#   ]
# }
