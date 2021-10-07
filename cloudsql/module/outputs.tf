output "name" {
  value = google_sql_database_instance.master.name
}

output "database_version" {
  value = google_sql_database_instance.master.database_version
}

output "self_link" {
  value = google_sql_database_instance.master.self_link
}
