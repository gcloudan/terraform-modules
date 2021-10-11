module "kms-keyring" {
  source     = "../../key-factory/module"
  project_id = var.project_id
  region     = var.region
  env        = var.env

  # Keyring
  type = "cloudsql"

  # set_encrypters_decrypters_for_keyring = true
  # encrypters_decrypters                 = "serviceAccount:service-${data.google_project.current_project.number}@compute-system.iam.gserviceaccount.com,user:samuel.lin@kasna.com.au,user:danny.tran@kasna.com.au"

  # set_owners_for_keyring = true
  # owners                 = "serviceAccount:service-${data.google_project.current_project.number}@compute-system.iam.gserviceaccount.com,user:samuel.lin@kasna.com.au,user:danny.tran@kasna.com.au"

  # Keys
  keys = [
    "high-availability-postgres"
  ]

  set_keys_encrypters_decrypters_for = ["high-availability-postgres"]
  keys_encrypters_decrypters         = ["user:samuel.lin@kasna.com.au,user:danny.tran@kasna.com.au,serviceAccount:service-${module.project-services.project_number}@gcp-sa-cloud-sql.iam.gserviceaccount.com"]

  set_keys_owners_for = []
  keys_owners         = []
}

module "cloudsql" {
  source           = "../module"
  name             = var.db_name
  database_version = var.database_version
  project_id       = var.project_id
  zone             = var.zone
  region           = var.region
  tier             = var.tier
  env              = var.env

  deletion_protection = var.deletion_protection

  ip_configuration = var.ip_configuration

  database_flags = var.database_flags

  additional_users = var.additional_users

  # Supports creation of both IAM Users and IAM Service Accounts with provided emails
  iam_user_emails = ["service-${module.project-services.project_number}@gcp-sa-cloud-sql.iam.gserviceaccount.com"
  ]

  encryption_key_name = module.kms-keyring.first_key_self_link

  additional_databases = [{
    name      = "db1"
    charset   = "",
    collation = ""
  }]
}

module "project-services" {
  source        = "../../project-services/module"
  project_id    = var.project_id
  activate_apis = var.activate_apis
  activate_api_identities = [
    { api   = "sqladmin.googleapis.com"
      roles = ["roles/cloudsql.serviceAgent"]
    }
  ]

  disable_services_on_destroy = false
  disable_dependent_services  = false
}