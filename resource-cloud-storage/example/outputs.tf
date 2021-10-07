output "names" {
  description = "Bucket names."
  value       = module.cloud_storage.names
}

output "names_list" {
  description = "List of bucket names."
  value       = module.cloud_storage.names_list
}
