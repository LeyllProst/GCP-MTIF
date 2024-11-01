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