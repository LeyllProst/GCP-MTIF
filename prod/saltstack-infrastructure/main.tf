# read remote state from gcs
data "terraform_remote_state" "vcp" {
  backend = "gcs"

  config = {
    bucket = "terraform-state-us-central1-mtif-439912"
    prefix = "terraform/state"
  }
}

# salt master instance
module "saltmaster" {
  source              = "../../modules/instance"
  instance_name       = "saltmaster"
  zone                = "us-central1-a"
  instance_type       = "e2-medium"
  update_stopping     = true
  deletion_protection = false

  network             = data.terraform_remote_state.vcp.outputs.main_network_name
  sub_network         = data.terraform_remote_state.vcp.outputs.subnetworks_name[1]
  network_ip          = "10.10.20.5"
  bootdisk_image_size = 20
  image               = "projects/rocky-linux-cloud/global/images/rocky-linux-9-optimized-gcp-v20241009"

  labels = {
    "purpose" = "salt-master"
  }

  startup_script = <<EOF
dnf update -y && dnf install -y mc vim net-tools bind-utils git 
curl -fsSL https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.repo | sudo tee /etc/yum.repos.d/salt.repo
dnf install -y salt-master salt-minion salt-ssh salt-syndic salt-cloud salt-api
systemctl enable salt-master && sudo systemctl start salt-master
systemctl enable salt-minion && sudo systemctl start salt-minion
systemctl enable salt-syndic && sudo systemctl start salt-syndic
systemctl enable salt-api && sudo systemctl start salt-api
EOF
}

