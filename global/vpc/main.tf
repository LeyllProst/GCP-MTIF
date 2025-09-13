module "vpc" {
  source = "git@github.com:LeyllProst/gcp-mtif-vpc.git?ref=v1.7.0"

  vpc_network_name = var.vpc_network_name
  ip_cidr_range    = var.ip_cidr_range
}
