# REMOTE STATE reading from gcs
data "terraform_remote_state" "vcp" {
  backend = "gcs"

  config = {
    bucket = "terraform-state-us-central1-mtif-439912"
    prefix = "terraform/state"
  }
}


# DOCKER-TESTSTAND instance
module "docker-teststand" {
  source = "git@github.com:LeyllProst/gcp-mtif-instances.git?ref=v2.1.2"

  project_id = data.terraform_remote_state.vcp.outputs.project
  network    = data.terraform_remote_state.vcp.outputs.vpc_network_self_link
  subnetwork = data.terraform_remote_state.vcp.outputs.vpc_subnetwork_self_link[0]

  instance_name                = var.docker_teststand_instance_name
  zone                         = var.docker_teststand_instance_zone
  network_ip                   = var.docker_teststand_network_ip
  instance_type                = var.docker_teststand_instance_type
  update_stopping              = var.docker_teststand_update_stopping
  deletion_protection          = var.docker_teststand_deletion_protection
  labels                       = var.docker_teststand_instance_labels
  bootdisk_image_size          = var.docker_teststand_bootdisk_image_size
  image                        = var.docker_teststand_image
  startup_script               = var.docker_teststand_startup_script
  assign_ephemeral_external_ip = var.docker_teststand_assign_ephemeral_external_ip
  tags                         = [var.docker_teststand_instance_name]
}


# FIREWALL rules
module "docker-teststand_firewall" {
  source = "git@github.com:LeyllProst/gcp-mtif-firewall.git?ref=v2.1.0"

  project = data.terraform_remote_state.vcp.outputs.project

  firewall_name = "docker-teststand-firewall-rules"
  network       = data.terraform_remote_state.vcp.outputs.vpc_network_self_link
  source_ranges = ["0.0.0.0/0"]
  target_tags   = [var.docker_teststand_instance_name]

  allow_rules = [
    {
      protocol = "tcp"
      ports    = ["8080"]
    }
  ]
}
