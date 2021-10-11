output "project_id" {
  value = module.project-services.project_id
}

output "current_project" {
  value = module.project-services.project_number
}
output "database_version" {
  value = module.cloudsql.database_version
}

// Master
output "instance_name" {
  value       = module.cloudsql.instance_name
  description = "The instance name for the master instance"
}

output "private_ip_address" {
  description = "The first private (PRIVATE) IPv4 address assigned for the master instance"
  value       = module.cloudsql.private_ip_address
}

output "instance_ip_address" {
  value       = module.cloudsql.instance_ip_address
  description = "The IPv4 address assigned for the master instance"
}

output "instance_first_ip_address" {
  value       = module.cloudsql.instance_first_ip_address
  description = "The first IPv4 address of the addresses assigned."
}

output "instance_connection_name" {
  value       = module.cloudsql.instance_connection_name
  description = "The connection name of the master instance to be used in connection strings"
}

output "instance_self_link" {
  value       = module.cloudsql.instance_self_link
  description = "The URI of the master instance"
}

output "instance_server_ca_cert" {
  value       = module.cloudsql.instance_server_ca_cert
  description = "The CA certificate information used to connect to the SQL instance via SSL"
}

output "instance_service_account_email_addresses" {
  value       = module.project-services.enabled_api_identities
  description = "The service account email addresses assigned to the master instance"
}

output "additional_users" {
  description = "List of maps of additional users and passwords"
  value       = module.cloudsql.additional_users
}

// Resources
output "primary" {
  value       = module.cloudsql.primary
  description = "The `google_sql_database_instance` resource representing the primary instance"
}

output "instances" {
  value       = module.cloudsql.instances
  description = "A list of all `google_sql_database_instance` resources we've created"
}
