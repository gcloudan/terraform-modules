module "project-services" {
  source        = "../../project-services/module"
  project_id    = var.project_id
  activate_apis = var.activate_apis

  disable_services_on_destroy = false
  disable_dependent_services  = false
}

module "cloud_storage" {
  source = "../module"

  names      = var.names
  env        = var.env
  location   = var.location
  project_id = var.project_id
  prefix     = var.prefix
  folders    = var.folders

  set_admin_roles = var.set_admin_roles
  bucket_admins   = var.bucket_admins

  set_storage_admin_roles = var.set_storage_admin_roles
  bucket_storage_admins   = var.bucket_storage_admins

  lifecycle_rules = [{
    action = {
      type          = "SetStorageClass"
      storage_class = "NEARLINE"
    }
    condition = {
      age                   = "30"
      matches_storage_class = "STANDARD,DURABLE_REDUCED_AVAILABILITY"
    }
  }]
}
