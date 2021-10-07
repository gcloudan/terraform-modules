module "networking" {
  source = "../module"

  network_name            = var.network_name
  subnetwork_name         = var.subnetwork_name
  ip_cidr_range           = var.ip_cidr_range
  secondary_ip_range_name = var.secondary_ip_range_name
  secondary_ip_cidr_range = var.secondary_ip_cidr_range
  auto_create_subnetworks = var.auto_create_subnetworks
  project_id              = var.project_id
}
