variable "vpc_network_name" {
  description = "VPC network name"
  type        = string
  default     = "backbonex"
}

variable "ip_cidr_range" {
  description = "subnetworks ip range"
  type        = list(string)
  default     = ["10.10.10.0/24", "10.10.20.0/24"]
}