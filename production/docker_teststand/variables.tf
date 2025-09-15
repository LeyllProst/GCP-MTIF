# DOCKER-TESTSTAND variables
variable "docker_teststand_update_stopping" {
  type    = bool
  default = true
}

variable "docker_teststand_deletion_protection" {
  type    = bool
  default = false
}

variable "docker_teststand_instance_name" {
  type    = string
  default = "docker-teststand"
}

variable "docker_teststand_instance_zone" {
  type    = string
  default = "us-central1-f"
}

variable "docker_teststand_network_ip" {
  type    = string
  default = "10.10.10.5"
}

variable "docker_teststand_instance_type" {
  type    = string
  default = "e2-standard-4"
}

variable "docker_teststand_instance_labels" {
  type = map(string)
  default = {
    "purpose" = "docker"
  }
}

variable "docker_teststand_bootdisk_image_size" {
  type    = number
  default = 30
}

variable "docker_teststand_image" {
  type    = string
  default = "projects/ubuntu-os-cloud/global/images/ubuntu-minimal-2504-plucky-amd64-v20250430"
}

variable "docker_teststand_assign_ephemeral_external_ip" {
  type    = bool
  default = true
}

variable "docker_teststand_startup_script" {
  type        = string
  description = "commands for startup"
  default     = <<-EOF
    #!/bin/bash
    set -e

    apt update && apt upgrade -y
  EOF
}
