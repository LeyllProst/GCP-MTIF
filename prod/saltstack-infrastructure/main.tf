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
dnf update -y
curl -fsSL https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.repo | sudo tee /etc/yum.repos.d/salt.repo
dnf install -y salt-master salt-minion salt-ssh salt-syndic salt-cloud salt-api
systemctl enable salt-master
systemctl enable salt-minion
systemctl enable salt-syndic && systemctl start salt-syndic
systemctl enable salt-api && systemctl start salt-api
echo "master: 10.10.20.5" > /etc/salt/minion.d/minion.conf
systemctl restart salt-minion

cat << 'EOG' >> /etc/salt/master.d/master.conf
## MASTER CONFIG parameters
interface: 10.10.20.5
ipv6: False
state_verbose: False

## ENVIRONMENT definitions
default_top: production
state_top_saltenv: production
top_file_merging_strategy: same

env_order:
  - production
  - maintenance

file_roots:
  production:
    - /opt/infrastructure/production
  maintenance:
    - /opt/infrastructure/maintenance
EOG

systemctl restart salt-master
EOF
}

# salt minions
module "salt-node-1" {
  source              = "../../modules/instance"
  instance_name       = "salt-node-1"
  zone                = "us-central1-a"
  instance_type       = "e2-small"
  update_stopping     = true
  deletion_protection = false

  network             = data.terraform_remote_state.vcp.outputs.main_network_name
  sub_network         = data.terraform_remote_state.vcp.outputs.subnetworks_name[1]
  bootdisk_image_size = 20
  image               = "projects/rocky-linux-cloud/global/images/rocky-linux-9-optimized-gcp-v20241009"

  labels = {
    "purpose" = "salt-minion"
  }

  startup_script = <<EOF
dnf update -y
curl -fsSL https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.repo | sudo tee /etc/yum.repos.d/salt.repo
dnf install -y salt-minion
systemctl enable salt-minion
echo "master: 10.10.20.5" > /etc/salt/minion.d/minion.conf
systemctl restart salt-minion
EOF
}

# cat /etc/salt/minion.d/role_base.conf
# grains:
#  role:
#    - base

# [root@saltmaster ~]# cat /etc/salt/minion.d/environment.conf 
# saltenv: maintenance

# [root@saltmaster ~]# cat /opt/infrastructure/production/top.sls 
# production:
#   '*':
#     - core

# [root@saltmaster ~]# cat /opt/infrastructure/maintenance/top.sls 
# maintenance:
#   '*':
#     - core

