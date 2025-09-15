# Remote State backend configuration
terraform {
  backend "gcs" {
    bucket = "terraform_remote_state_us-central1_mtif-439912"
    prefix = "terraform/saltstack-infrastructure"
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



# SALTMASTER instance
module "saltmaster" {
  source = "git@github.com:LeyllProst/gcp-mtif-instances.git?ref=v2.0.2"

  project_id          = data.terraform_remote_state.trs.outputs.project_id
  network    = data.terraform_remote_state.vpc.outputs.vpc_network_self_link
  subnetwork = data.terraform_remote_state.vpc.outputs.vpc_subnetwork_self_link[1]
  instance_name       = var.saltmaster-instance_name
  zone                = var.saltmaster-instance_zone
  network_ip          = var.saltmaster-network_ip
  instance_type       = var.saltmaster-instance_type
  update_stopping     = var.update_stopping
  deletion_protection = var.deletion_protection
  labels              = var.saltmaster-labels

  bootdisk_image_size = var.saltmaster-bootdisk_image_size
  image               = var.saltmaster-image

  startup_script = var.saltmaster-startup_script
}




# REPOSITORY salt minion instance
module "repository" {
  source = "git@github.com:LeyllProst/gcp-mtif-instances.git?ref=v2.0.2"

  project_id          = data.terraform_remote_state.trs.outputs.project_id
  network    = data.terraform_remote_state.vpc.outputs.vpc_network_self_link
  subnetwork = data.terraform_remote_state.vpc.outputs.vpc_subnetwork_self_link[1]
  instance_name       = var.repository-instance_name
  zone                = var.repository-instance_zone
  instance_type       = var.repository-instance_type
  update_stopping     = var.update_stopping
  deletion_protection = var.deletion_protection
  labels              = var.repository-labels

  bootdisk_image_size = var.repository-bootdisk_image_size
  image               = var.repository-image

  startup_script = var.repository-startup_script
}

# FIREWALL rules
module "saltstack_firewall" {
  source = "git@github.com:LeyllProst/gcp-mtif-firewall.git?ref=v2.1.0"

  project          = data.terraform_remote_state.trs.outputs.project_id
  firewall_name = "saltstack-firewall-rules"
  network       = data.terraform_remote_state.vpc.outputs.vpc_network_self_link

  source_ranges = ["0.0.0.0/0"]

  allow_rules = [
    {
      protocol = "tcp"
      ports    = ["4505", "4506"]
    }
  ]
}
