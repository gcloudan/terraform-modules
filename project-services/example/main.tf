module "project-services" {
  source = "../module"

  project_id = var.project_id

  activate_apis = var.activate_apis

  disable_services_on_destroy = false
  disable_dependent_services = false
}