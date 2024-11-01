variable "project_id" {
  type        = string
  description = "Project ID"
  default     = "mtif-439912"
}

variable "region" {
  type        = string
  description = "region of this infrastructure"
  default     = "us-central1"
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