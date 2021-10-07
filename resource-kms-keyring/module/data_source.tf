data google_project current_project {
  project_id = var.project_id
}

data "google_kms_key_ring" "existing_keyring" {
  name     = format("%s_%s", var.type, var.suffix)
  location = var.region
  project  = var.project_id
}
