resource "google_project_service" "compute" {
  project            = var.project_id
  service            = "compute.googleapis.com"
  disable_on_destroy = false
}
resource "google_project_service" "cloudresourcemanager" {
  project            = var.project_id
  service            = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_instance" "default" {
  name                      = var.name
  machine_type              = var.machine_type
  zone                      = var.zone
  project                   = var.project_id
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork_project = var.subnetwork_project
    subnetwork         = var.subnetwork
    access_config {}
  }

  scheduling {
    preemptible       = true
    automatic_restart = false
  }

  labels = var.labels
  tags   = var.tags

  # Before we can create a compute instance we have to enable the the Compute API
  depends_on = [
    google_project_service.cloudresourcemanager,
    google_project_service.compute
  ]
}
