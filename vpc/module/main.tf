resource "google_compute_network" "private_network" {
  provider                = google-beta
  project                 = var.project_id
  name                    = var.network_name
  auto_create_subnetworks = var.auto_create_subnetworks
}

resource "google_compute_global_address" "private_ip_address" {
  provider = google-beta

  name          = "private-ip-address"
  project       = var.project_id
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.private_network.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider = google-beta

  network                 = google_compute_network.private_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "google_compute_subnetwork" "subnet" {
  name                     = var.subnetwork_name
  project                  = var.project_id
  ip_cidr_range            = var.ip_cidr_range
  region                   = var.region
  network                  = google_compute_network.private_network.id
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = var.secondary_ip_range_name
    ip_cidr_range = var.secondary_ip_cidr_range
  }
  depends_on = [
    google_compute_network.private_network
  ]
}

resource "google_compute_firewall" "firewall" {
  name    = "allow-incoming-ssh-from-iap"
  project = var.project_id
  network = google_compute_network.private_network.self_link

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "8080", "1000-2000"]
  }

  source_ranges = [
    "35.235.240.0/20"
  ]

  source_tags = ["web"]
}
