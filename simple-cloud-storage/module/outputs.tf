output "name" {
  description = "Bucket names."
  value       = google_storage_bucket.buckets.name
}