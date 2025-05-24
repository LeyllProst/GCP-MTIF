# DOCKER-TESTSTAND variables
variable "docker-teststand-update_stopping" {
  type    = bool
  default = true
}

variable "docker-teststand-deletion_protection" {
  type    = bool
  default = false
}

variable "docker-teststand-instance_name" {
  type    = string
  default = "docker-teststand"
}

variable "docker-teststand_instance_zone" {
  type    = string
  default = "us-central1-f"
}

variable "docker-teststand-network_ip" {
  type    = string
  default = "10.10.10.5"
}

variable "docker-teststand-instance_type" {
  type    = string
  default = "e2-standard-2"
}

variable "docker-teststand-instance_labels" {
  type = map(string)
  default = {
    "purpose" = "docker"
  }
}

variable "docker-teststand-bootdisk_image_size" {
  type    = number
  default = 30
}

variable "docker-teststand-image" {
  type    = string
  default = "projects/ubuntu-os-cloud/global/images/ubuntu-2404-noble-amd64-v20250409"
}

variable "docker-teststand-assign_ephemeral_external_ip" {
  type    = bool
  default = true
}

variable "docker-teststand-startup_script" {
  type        = string
  description = "commands for startup"
  default     = <<-EOF
    #!/bin/bash
    set -e
    
    apt update && apt upgrade -y
    apt install docker-compose -y
  EOF
}