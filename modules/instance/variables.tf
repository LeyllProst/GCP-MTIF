
variable "instance_name" {
  type        = string
  description = "instance name"
}

variable "zone" {
  type        = string
  description = "zone of the instance"
  default     = "us-central1-f"
}

variable "instance_type" {
  type        = string
  description = "machine type of the instance"
  default     = "e2-medium"
}

variable "update_stopping" {
  type        = bool
  description = "allow stopping for update"
  default     = true
}

variable "deletion_protection" {
  type        = bool
  description = "allow delete protection"
  default     = false
}

variable "network" {
  type        = string
  description = "network where instance belong to"
}

variable "sub_network" {
  type        = string
  description = "sub network where instance belong to"
}

variable "bootdisk_autodelete" {
  type        = bool
  description = "boot disk auto delete"
  default     = true
}

variable "bootdisk_image_size" {
  type        = number
  description = "bootdisk image size"
  default     = 10
}

variable "image" {
  type        = string
  description = "Operation System"
  default     = "projects/debian-cloud/global/images/debian-12-bookworm-v20241009"
}

variable "labels" {
  type = map(string)
  default = {
    "created by" = "terraform"
  }
}

variable "startup_script" {
  type        = string
  description = "commands for startup"
  default     = "echo 'startup'"

}
