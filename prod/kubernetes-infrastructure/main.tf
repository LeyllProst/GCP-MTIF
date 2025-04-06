# REMOTE STATE reading from gcs
data "terraform_remote_state" "vcp" {
  backend = "gcs"

  config = {
    bucket = "terraform-state-us-central1-mtif-439912"
    prefix = "terraform/state"
  }
}

module "kubernetes" {
    source = "git@github.com:LeyllProst/gcp-mtif-kubernetes.git?ref=v1.0.0"

    project_id = data.terraform_remote_state.vcp.outputs.project_id
    network             = data.terraform_remote_state.vcp.outputs.main_network_name
    sub_network         = data.terraform_remote_state.vcp.outputs.subnetworks_name[1]

    name = var.kubernetes_instance-name
    
}