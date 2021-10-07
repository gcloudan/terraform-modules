locals {
  prefix       = var.prefix == "" ? "${lower(var.project_id)}-" : "${lower(var.prefix)}-"
  suffix       = var.randomise_suffix ? "-${random_string.random_string_suffix.id}-${var.env}" : var.env
  names_set    = toset(var.names)
  buckets_list = [for name in var.names : google_storage_bucket.buckets[name]]
  folder_list = flatten([
    for bucket, folders in var.folders : [
      for folder in folders : {
        bucket = bucket,
        folder = folder
      }
    ]
  ])
}
