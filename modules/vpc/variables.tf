variable "region" {
  type = string
}

variable "project_id" {
  type = string
}

variable "main_network_name" {
  type        = string
  description = "Name for backbone"
  default     = "backbone"
}

variable "ip_cidr_range" {
  type        = list(string)
  description = "List of The range of internal addresses that are owned by this subnetwork."
  default     = ["10.10.10.0/24", "10.10.20.0/24"]
}

