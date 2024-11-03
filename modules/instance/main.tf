
resource "google_compute_instance" "this" {
  name                      = var.instance_name
  zone                      = var.zone
  machine_type              = var.instance_type
  allow_stopping_for_update = var.update_stopping
  deletion_protection       = var.deletion_protection
  labels                    = var.labels

  network_interface {
    network    = var.network
    subnetwork = var.sub_network
  }

  boot_disk {
    auto_delete = var.bootdisk_autodelete
    initialize_params {
      image = var.image
      size  = var.bootdisk_image_size
    }
  }

  metadata = {
    startup-script = "${var.startup_script}"
  }
}
