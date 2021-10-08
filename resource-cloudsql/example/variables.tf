variable "region" {
  default = "australia-southeast1"
}

variable "zone" {
  type        = string
  description = "The zone for the master instance, it should be something like: `us-central1-a`, `us-east1-c`."
  default     = "australia-southeast1-a"
}

variable "project_id" {
  type    = string
  default = "cert-pr"
}

variable "activate_apis" {
  type = list
  default = [
    "sqladmin.googleapis.com",
    "compute.googleapis.com",
    "servicenetworking.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "sql-component.googleapis.com"
  ]
}

variable "db_name" {
  description = "The name of the SQL Database instance"
  default     = "example-postgres"
}

variable "database_version" {
  default = "POSTGRES_9_6"
}

variable "tier" {
  description = "The tier for the master instance."
  type        = string
  default     = "db-custom-4-13312"
}

variable "deletion_protection" {
  description = "Used to block Terraform from deleting a SQL Instance."
  type        = bool
  default     = false
}

variable "ip_configuration" {
  description = "The ip configuration for the master instances."
  type = object({
    private_network = string
    ipv4_enabled    = bool
    require_ssl     = bool
  })
  default = {
    private_network = "projects/cert-pr/global/networks/vpc-network"
    ipv4_enabled    = false
    require_ssl     = true
  }
}

variable "database_flags" {
  description = "The database flags for the master instance. See [more details](https://cloud.google.com/sql/docs/postgres/flags)"
  type = list(object({
    name  = string
    value = string
  }))
  default = [
    {
      name  = "cloudsql.iam_authentication"
      value = "On"
    },
  ]
}
variable "additional_users" {
  description = "A list of users to be created in your cluster"
  type = list(object({
    name     = string
    password = string
  }))
  default = [
    {
      name     = "tftest2"
      password = "abcdefg"
      host     = "localhost"
    },
    {
      name     = "tftest3"
      password = "abcdefg"
      host     = "localhost"
    },
  ]
}

variable "iam_user_emails" {
  description = "A list of IAM users to be created in your cluster"
  type        = list(string)
  default = [
    "danny.tran@kasna.com.au",
    "samuel.lin@kasna.com.au",
  ]
}

variable "env" {
  default = "sandpit"
}