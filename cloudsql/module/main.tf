resource "random_string" "random_string_suffix" {
  length  = 4
  special = false
  upper   = false
}
resource "google_sql_database_instance" "master" {
  name                = "${var.name}-${random_string.random_string_suffix.id}"
  database_version    = "POSTGRES_13"
  region              = var.region
  project             = var.project_id
  deletion_protection = false

  settings {
    tier = "db-custom-4-13312"
  }
}
