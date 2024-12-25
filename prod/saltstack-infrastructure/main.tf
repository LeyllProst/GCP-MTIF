# REMOTE STATE reading from gcs
data "terraform_remote_state" "vcp" {
  backend = "gcs"

  config = {
    bucket = "terraform-state-us-central1-mtif-439912"
    prefix = "terraform/state"
  }
}




# SALTMASTER instance
module "saltmaster" {
  source = "git@github.com:LeyllProst/gcp-mtif-instances.git?ref=v1.1.0"

  network             = data.terraform_remote_state.vcp.outputs.main_network_name
  sub_network         = data.terraform_remote_state.vcp.outputs.subnetworks_name[1]
  instance_name       = var.saltmaster-instance_name
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
  source = "git@github.com:LeyllProst/gcp-mtif-instances.git?ref=v1.1.0"

  network             = data.terraform_remote_state.vcp.outputs.main_network_name
  sub_network         = data.terraform_remote_state.vcp.outputs.subnetworks_name[1]
  instance_name       = var.repository-instance_name
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
  source = "git@github.com:LeyllProst/gcp-mtif-firewall.git?ref=v1.0.0"

  firewall_name                = "saltstack firewall rules"
  network             = data.terraform_remote_state.vcp.outputs.main_network_name

  allow_rules = [
    {
      protocol = "tcp"
      ports    = ["4505", "4506", "443"]
    }
  ]
} 
