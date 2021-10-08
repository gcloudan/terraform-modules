module "project-services" {
  source        = "../../project-services/module"
  project_id    = var.project_id
  activate_apis = var.activate_apis

  disable_services_on_destroy = false
  disable_dependent_services  = false
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
  iam_user_emails = var.iam_user_emails

  depends_on = [
    module.project-services
  ]
}