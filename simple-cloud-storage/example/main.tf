module "project-services" {
  source        = "../../project-services/module"
  project_id    = var.project_id
  activate_apis = var.activate_apis

  disable_services_on_destroy = false
  disable_dependent_services  = false
}

module "cloud_storage" {
  source = "../module"

  name       = var.name
  location   = var.location
  project_id = var.project_id
}
