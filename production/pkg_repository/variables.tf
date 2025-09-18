# COMMON variables
variable "update_stopping" {
  type    = bool
  default = true
}

variable "deletion_protection" {
  type    = bool
  default = false
}

# pkg_repository salt minion variables
variable "pkg_repository_instance_name" {
  type    = string
  default = "pkg-repository"
}

variable "pkg_repository_instance_zone" {
  type    = string
  default = "us-central1-f"
}

variable "pkg_repository_instance_type" {
  type    = string
  default = "e2-medium"
}

variable "pkg_repository_labels" {
  type = map(string)
  default = {
    "purpose" = "salt-minion"
  }
}

variable "pkg_repository_bootdisk_image_size" {
  type    = number
  default = 20
}

variable "pkg_repository_image" {
  type    = string
  default = "projects/rocky-linux-cloud/global/images/rocky-linux-9-optimized-gcp-v20241009"
}

variable "pkg_repository_startup_script" {
  type        = string
  description = "commands for startup"
  default     = <<-EOF
    #!/bin/bash
    set -e
    
    dnf update -y
    curl -fsSL https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.repo | tee /etc/yum.repos.d/salt.repo
    
    dnf install -y salt-minion
    echo "master: 10.10.20.5" > /etc/salt/minion.d/minion.conf
    systemctl enable salt-minion
    systemctl restart salt-minion
  EOF
}
