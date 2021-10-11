data google_project current_project {
  project_id = var.project_id
}

data "google_kms_key_ring" "existing_key_ring" {
  name     = var.key_ring_name
  location = var.region
  project  = var.project_id
}
