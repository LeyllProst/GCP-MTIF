# COMMON variables
variable "update_stopping" {
  type    = bool
  default = true
}

variable "deletion_protection" {
  type    = bool
  default = false
}




# SALTMASTER variables
variable "saltmaster-instance_name" {
  type    = string
  default = "saltmaster"
}

variable "saltmaster-instance_zone" {
  type    = string
  default = "us-central1-f"
}

variable "saltmaster-network_ip" {
  type    = string
  default = "10.10.20.5"
}

variable "saltmaster-instance_type" {
  type    = string
  default = "e2-medium"
}

variable "saltmaster-labels" {
  type = map(string)
  default = {
    "purpose" = "salt-master"
  }
}

variable "saltmaster-bootdisk_image_size" {
  type    = number
  default = 20
}

variable "saltmaster-image" {
  type    = string
  default = "projects/rocky-linux-cloud/global/images/rocky-linux-9-optimized-gcp-v20241009"
}

variable "saltmaster-startup_script" {
  type        = string
  description = "commands for startup"
  default     = <<-EOF
    #!/bin/bash
    set -e
    
    dnf update -y
    curl -fsSL https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.repo | tee /etc/yum.repos.d/salt.repo
    
    dnf install -y salt-master salt-minion salt-ssh salt-syndic salt-cloud salt-api
    echo 'master: 10.10.20.5' > /etc/salt/minion.d/minion.conf
    systemctl enable salt-syndic && systemctl start salt-syndic
    systemctl enable salt-api && systemctl start salt-api
    systemctl enable salt-master && systemctl start salt-master
    systemctl enable salt-minion && systemctl start salt-minion
  EOF
}
