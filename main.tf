provider "google" {
  project = "mtif-439912"
}

resource "google_compute_network" "backbone" {
  name = "backbone"
}