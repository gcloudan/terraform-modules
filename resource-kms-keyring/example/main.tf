module "kms-keyring" {
  source     = "../module"
  project_id = var.project_id
  region     = var.region

  type = "ai"

  set_encrypters_decrypters_for = "ai"
  encrypters_decrypters         = "serviceAccount:service-${data.google_project.current_project.number}@compute-system.iam.gserviceaccount.com,user:samuel.lin@kasna.com.au"

  set_owners_for = "ai"
  owners         = "serviceAccount:service-${data.google_project.current_project.number}@compute-system.iam.gserviceaccount.com,user:samuel.lin@kasna.com.au"
}

module "project-services" {
  source        = "../../project-services/module"
  project_id    = var.project_id
  activate_apis = var.activate_apis

  disable_services_on_destroy = false
  disable_dependent_services  = false
}