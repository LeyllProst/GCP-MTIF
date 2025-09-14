# DOCKER-TESTSTAND variables
variable "monitoring_update_stopping" {
  type    = bool
  default = true
}

variable "monitoring_deletion_protection" {
  type    = bool
  default = false
}

variable "monitoring_instance_name" {
  type    = string
  default = "monitoring"
}

variable "monitoring_instance_zone" {
  type    = string
  default = "us-central1-f"
}

variable "monitoring_network_ip" {
  type    = string
  default = ""
}

variable "monitoring_instance_type" {
  type    = string
  default = "e2-standard-4"
}

variable "monitoring_instance_labels" {
  type = map(string)
  default = {
    "purpose" = "infrastructure_monitoring"
  }
}

variable "monitoring_bootdisk_image_size" {
  type    = number
  default = 30
}

variable "monitoring_image" {
  type    = string
  default = "projects/ubuntu-os-cloud/global/images/ubuntu-minimal-2504-plucky-amd64-v20250430"
}

variable "monitoring_assign_ephemeral_external_ip" {
  type    = bool
  default = true
}

variable "monitoring_startup_script" {
  type        = string
  description = "commands for startup"
  default     = <<-EOF
    #!/bin/bash
    set -e

    apt update && apt upgrade -y
  EOF
}
