module "project-services" {
  source        = "../../project-services/module"
  project_id    = var.project_id
  activate_apis = var.activate_apis

  disable_services_on_destroy = false
  disable_dependent_services  = false
}

module "gce" {
  source = "../module"

  name                    = var.name
  machine_type            = var.machine_type
  zone                    = var.zone
  secondary_ip_cidr_range = var.secondary_ip_cidr_range
  ip_cidr_range           = var.ip_cidr_range
  tags                    = var.tags
  project_id              = var.project_id
  subnetwork_project      = var.subnetwork_project
  subnetwork              = var.subnetwork

  labels = var.labels
}
