
resource "random_string" "random_string_suffix" {
  length  = 4
  special = false
  upper   = false
}

resource "google_storage_bucket" "buckets" {

  name          = "${var.name}-${random_string.random_string_suffix.id}"
  project       = var.project_id
  location      = var.location
  storage_class = var.storage_class

  force_destroy = var.force_destroy

  uniform_bucket_level_access = var.bucket_policy_only

  versioning {
    enabled = var.versioning
  }
}