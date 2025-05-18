variable "project_id" {
  description = "project ID"
  type        = string
  default     = "mtif-439912"
}

variable "region" {
  description = "region of this infrastructure"
  type        = string
  default     = "us-central1"
}

variable "network_name" {
  description = "VPC network name"
  type        = string
  default     = "backbonex"
}

variable "ip_cidr_range" {
  description = "subnetworks ip range"
  type        = list(string)
  default     = ["10.10.10.0/24", "10.10.20.0/24"]
}