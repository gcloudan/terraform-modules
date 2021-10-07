
resource "random_string" "random_string_suffix" {
  length  = 4
  special = false
  upper   = false
}

resource "google_storage_bucket" "buckets" {
  for_each = local.names_set

  name          = "${local.prefix}${lower(each.value)}${local.suffix}"
  project       = var.project_id
  location      = var.location
  storage_class = var.storage_class

  force_destroy = var.force_destroy

  uniform_bucket_level_access = var.bucket_policy_only

  versioning {
    enabled = var.versioning
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules
    content {
      action {
        type          = lifecycle_rule.value.action.type
        storage_class = lookup(lifecycle_rule.value.action, "storage_class", null)
      }
      condition {
        age                        = lookup(lifecycle_rule.value.condition, "age", null)
        created_before             = lookup(lifecycle_rule.value.condition, "created_before", null)
        with_state                 = lookup(lifecycle_rule.value.condition, "with_state", lookup(lifecycle_rule.value.condition, "is_live", false) ? "LIVE" : null)
        matches_storage_class      = contains(keys(lifecycle_rule.value.condition), "matches_storage_class") ? split(",", lifecycle_rule.value.condition["matches_storage_class"]) : null
        num_newer_versions         = lookup(lifecycle_rule.value.condition, "num_newer_versions", null)
        custom_time_before         = lookup(lifecycle_rule.value.condition, "custom_time_before", null)
        days_since_custom_time     = lookup(lifecycle_rule.value.condition, "days_since_custom_time", null)
        days_since_noncurrent_time = lookup(lifecycle_rule.value.condition, "days_since_noncurrent_time", null)
        noncurrent_time_before     = lookup(lifecycle_rule.value.condition, "noncurrent_time_before", null)
      }
    }
  }
  dynamic "retention_policy" {
    for_each = lookup(var.retention_policy, each.value, {}) != {} ? [var.retention_policy[each.value]] : []
    content {
      is_locked        = lookup(retention_policy.value, "is_locked", null)
      retention_period = lookup(retention_policy.value, "retention_period", null)
    }
  }
}

resource "google_storage_bucket_iam_binding" "admins" {
  for_each = var.set_admin_roles ? local.names_set : []
  bucket   = google_storage_bucket.buckets[each.value].name
  role     = "roles/storage.objectAdmin"
  members = compact(
    concat(
      var.admins,
      split(
        ",",
        lookup(var.bucket_admins, each.value, ""),
      ),
    ),
  )
}

resource "google_storage_bucket_iam_binding" "creators" {
  for_each = var.set_creator_roles ? local.names_set : toset([])
  bucket   = google_storage_bucket.buckets[each.value].name
  role     = "roles/storage.objectCreator"
  members = compact(
    concat(
      var.creators,
      split(
        ",",
        lookup(var.bucket_creators, each.value, ""),
      ),
    ),
  )
}

resource "google_storage_bucket_iam_binding" "viewers" {
  for_each = var.set_viewer_roles ? local.names_set : toset([])
  bucket   = google_storage_bucket.buckets[each.value].name
  role     = "roles/storage.objectViewer"
  members = compact(
    concat(
      var.viewers,
      split(
        ",",
        lookup(var.bucket_viewers, each.value, ""),
      ),
    ),
  )
}

resource "google_storage_bucket_iam_binding" "hmac_key_admins" {
  for_each = var.set_hmac_key_admin_roles ? local.names_set : toset([])
  bucket   = google_storage_bucket.buckets[each.key].name
  role     = "roles/storage.hmacKeyAdmin"
  members = compact(
    concat(
      var.hmac_key_admins,
      split(
        ",",
        lookup(var.bucket_hmac_key_admins, each.key, ""),
      ),
    ),
  )
}

resource "google_storage_bucket_iam_binding" "storage_admins" {
  for_each = var.set_storage_admin_roles ? local.names_set : toset([])
  bucket   = google_storage_bucket.buckets[each.value].name
  role     = "roles/storage.admin"
  members = compact(
    concat(
      var.storage_admins,
      split(
        ",",
        lookup(var.bucket_storage_admins, each.value, ""),
      ),
    ),
  )
}

resource "google_storage_bucket_object" "folders" {
  for_each = { for obj in local.folder_list : "${obj.bucket}_${obj.folder}" => obj }
  bucket   = google_storage_bucket.buckets[each.value.bucket].name
  name     = "${each.value.folder}/" # Declaring an object with a trailing '/' creates a directory
  content  = "foo"                   # Note that the content string isn't actually used, but is only there since the resource requires it
}
