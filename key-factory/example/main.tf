module "kms-keyring" {
  source     = "../module"
  project_id = var.project_id
  region     = var.region
  env        = var.env

  # Keyring
  type = "yuzu"

  # set_encrypters_decrypters_for_keyring = true
  # encrypters_decrypters                 = "serviceAccount:service-${data.google_project.current_project.number}@compute-system.iam.gserviceaccount.com,user:samuel.lin@kasna.com.au,user:danny.tran@kasna.com.au"

  # set_owners_for_keyring = true
  # owners                 = "serviceAccount:service-${data.google_project.current_project.number}@compute-system.iam.gserviceaccount.com,user:samuel.lin@kasna.com.au,user:danny.tran@kasna.com.au"

  # Keys
  keys = [
    "key1"
  ]

  set_keys_encrypters_decrypters_for = ["key1"]
  keys_encrypters_decrypters = ["serviceAccount:service-${data.google_project.current_project.number}@compute-system.iam.gserviceaccount.com,user:samuel.lin@kasna.com.au,user:danny.tran@kasna.com.au"]

  set_keys_owners_for = ["key1"]
  keys_owners = ["serviceAccount:service-${data.google_project.current_project.number}@compute-system.iam.gserviceaccount.com,user:samuel.lin@kasna.com.au,user:danny.tran@kasna.com.au"]
}

module "project-services" {
  source        = "../../project-services/module"
  project_id    = var.project_id
  activate_apis = var.activate_apis

  disable_services_on_destroy = false
  disable_dependent_services  = false
}