# Resource Cloud SQL
To make better use of this module, check the [Usage](#Usage) section.

## Prerequisites
---

### Installation Dependencies

- Terraform version 0.13.x or above

### Configure a Service Account
In order to execute this module you must have a Service Account with the following:

#### Roles

- Cloud SQL Admin: `roles/cloudsql.admin`
- Compute Network Admin: `roles/compute.networkAdmin`
- Cloud KMS Admin: `roles/cloudkms.admin`
- (Optional) Service Account roles: `role/iamserviceAccountCreator` or `roles/iam.serviceAccountAdmin`

### Enable APIs

In order to operate with the Service Account you must activate the following APIs on the project where the Service Account was created:

- Cloud SQL Admin API: `sqladmin.googleapis.com`

In order to use Private Service Access, required for using Private IPs, you must activate
the following APIs on the project where your VPC resides:

- Cloud SQL Admin API: `sqladmin.googleapis.com`
- Compute Engine API: `compute.googleapis.com`
- Service Networking API: `servicenetworking.googleapis.com`
- SQL Component API: `sql-component.googleapis.com`
- Cloud KMS API: `cloudkms.googleapis.com`
- Cloud Resource Manager API: `cloudresourcemanager.googleapis.com`

## Changelog
---
[1.0.0] - 2021-08-24
---
* First versioned release of the module
* First Codefresh pipeline

[1.0.1] - 2021-09-22
---
* Fixed an issue in the module after Codefresh migration
* Added a random suffix for creating a Service Account in the example

### Usage

For PostgreSQL with:
- CMEK Keyring and Key creation
```
module "kms" {
  source  = "internal/cloudsql/repo//"
  source     = "../../key-factory/module"
  
  project_id = var.project_id
  region     = var.region
  env        = var.env

  # Keyring
  type = "cloudsql"

  set_encrypters_decrypters_for_keyring = true
  encrypters_decrypters                 = "serviceAccount:service-${data.google_project.current_project.number}@compute-system.iam.gserviceaccount.com,user:samuel.lin@kasna.com.au,user:danny.tran@kasna.com.au"

  # Keys
  keys = [
    "high-availability-postgres"
  ]

  set_keys_encrypters_decrypters_for = ["high-availability-postgres"]
  keys_encrypters_decrypters         = ["user:samuel.lin@kasna.com.au,user:danny.tran@kasna.com.au,serviceAccount:service-${module.project-services.project_number}@gcp-sa-cloud-sql.iam.gserviceaccount.com"]

  set_keys_owners_for = []
  keys_owners         = []
}

module "cloudsql" {
  source           = "../module"
  name             = var.db_name
  database_version = var.database_version
  project_id       = var.project_id
  zone             = var.zone
  region           = var.region
  tier             = var.tier
  env              = var.env

  deletion_protection = var.deletion_protection

  ip_configuration = var.ip_configuration

  database_flags = var.database_flags

  encryption_key_name = module.kms-keyring.first_key_self_link
}

module "project-services" {
  source        = "../../project-services/module"
  project_id    = var.project_id
  activate_apis = var.activate_apis

  disable_services_on_destroy = false
  disable_dependent_services  = false
  }
}
```

For PostgreSQL with:

- CMEK Keyring and Key creation
- Database creation
- Service Agent creation with roles:
  - `roles/cloudkms.cryptoKeyEncrypterDecrypter`
  - `roles/cloudsql.serviceAgent`
  - `roles/cloudsql.instanceUser`
```hcl
module "kms" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/mysql"
  source     = "../../key-factory/module"
  
  project_id = var.project_id
  region     = var.region
  env        = var.env

  # Keyring
  type = "cloudsql"

  set_encrypters_decrypters_for_keyring = true
  encrypters_decrypters                 = "serviceAccount:service-${data.google_project.current_project.number}@compute-system.iam.gserviceaccount.com,user:samuel.lin@kasna.com.au,user:danny.tran@kasna.com.au"

  # Keys
  keys = [
    "high-availability-postgres"
  ]

  set_keys_encrypters_decrypters_for = ["high-availability-postgres"]
  keys_encrypters_decrypters         = ["user:samuel.lin@kasna.com.au,user:danny.tran@kasna.com.au,serviceAccount:service-${module.project-services.project_number}@gcp-sa-cloud-sql.iam.gserviceaccount.com"]

  set_keys_owners_for = []
  keys_owners         = []
}

module "cloudsql" {
  source           = "../module"
  name             = var.db_name
  database_version = var.database_version
  project_id       = var.project_id
  zone             = var.zone
  region           = var.region
  tier             = var.tier
  env              = var.env

  deletion_protection = var.deletion_protection

  ip_configuration = var.ip_configuration

  database_flags = var.database_flags

  additional_users = var.additional_users

  # Supports creation of both IAM Users and IAM Service Accounts with provided emails
  iam_user_emails = [
    "service-${module.project-services.project_number}@gcp-sa-cloud-sql.iam.gserviceaccount.com"
  ]

  encryption_key_name = module.kms-keyring.first_key_self_link

  additional_databases = [{
    name      = "db1"
    charset   = "",
    collation = ""
  }]
}

module "project-services" {
  source        = "../../project-services/module"
  project_id    = var.project_id
  activate_apis = var.activate_apis
  activate_api_identities = [
    { api   = "sqladmin.googleapis.com"
      roles = ["roles/cloudsql.serviceAgent"]
    }
  ]

  disable_services_on_destroy = false
  disable_dependent_services  = false
  }
}
```

For MySQL with:

- CMEK Keyring and Key creation

```hcl
module "kms" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/mysql"
  source     = "../../key-factory/module"
  
  project_id = var.project_id
  region     = var.region
  env        = var.env

  # Keyring
  type = "cloudsql"

  set_encrypters_decrypters_for_keyring = true
  encrypters_decrypters                 = "serviceAccount:service-${data.google_project.current_project.number}@compute-system.iam.gserviceaccount.com,user:samuel.lin@kasna.com.au,user:danny.tran@kasna.com.au"

  # Keys
  keys = [
    "high-availability-postgres"
  ]

  set_keys_encrypters_decrypters_for = ["high-availability-postgres"]
  keys_encrypters_decrypters         = ["user:samuel.lin@kasna.com.au,user:danny.tran@kasna.com.au,serviceAccount:service-${module.project-services.project_number}@gcp-sa-cloud-sql.iam.gserviceaccount.com"]

  set_keys_owners_for = []
  keys_owners         = []
}

module "mysql" {
  source           = "../module"
  name             = var.db_name
  database_version = "MYSQL_8_0"
  project_id       = var.project_id
  zone             = var.zone
  region           = var.region
  tier             = var.tier
  env              = var.env

  deletion_protection = var.deletion_protection

  ip_configuration = {
    enabled                        = true
    binary_log_enabled             = true # HA method using REGIONAL availability_type requires binary logs to be enabled
    start_time                     = null
    location                       = null
    point_in_time_recovery_enabled = false
    transaction_log_retention_days = null
    retained_backups               = null
    retention_unit                 = null
  }

  encryption_key_name = module.kms-keyring.first_key_self_link
}

module "project-services" {
  source        = "../../project-services/module"
  project_id    = var.project_id
  activate_apis = var.activate_apis
  activate_api_identities = [
    { api   = "sqladmin.googleapis.com"
      roles = ["roles/cloudsql.serviceAgent"]
    }
  ]

  disable_services_on_destroy = false
  disable_dependent_services  = false
  }
}
```

## Tests

1. PASS: Create 1 database instance with 0 database
1. PASS: Create 1 database instance with 1 database
1. PASS: Create 1 database instance with 0 database with CMEK

1. PASS: Create 1 database instance with 1 database with CMEK with no roles
1. PASS: Create 1 database instance with 1 database with CMEK with roles

1. PASS: Create 1 database instance with 2 database with CMEK with no roles
1. PASS: Create 1 database instance with 2 database with CMEK with roles

1. PASS: Create 1 mysql database instance with 2 database with CMEK with roles
1. Create a database instance with a read replica with the same CMEK and with roles

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_sql_database_instance.default](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_sql_database_instance) | resource |
| [google_project_iam_member.iam_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_sql_database.additional_databases](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database) | resource |
| [google_sql_user.additional_users](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user) | resource |
| [google_sql_user.iam_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user) | resource |
| [random_id.additional_passwords](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_id.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [google_project.current_project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_activation_policy"></a> [activation\_policy](#input\_activation\_policy) | The activation policy for the master instance. Can be either `ALWAYS`, `NEVER` or `ON_DEMAND`. | `string` | `"ALWAYS"` | no |
| <a name="input_additional_databases"></a> [additional\_databases](#input\_additional\_databases) | A list of databases to be created in your cluster | <pre>list(object({<br>    name      = string<br>    charset   = string<br>    collation = string<br>  }))</pre> | `[]` | no |
| <a name="input_additional_users"></a> [additional\_users](#input\_additional\_users) | A list of users to be created in your cluster | <pre>list(object({<br>    name     = string<br>    password = string<br>  }))</pre> | `[]` | no |
| <a name="input_availability_type"></a> [availability\_type](#input\_availability\_type) | The availability type for the master instance. This is only used to set up high availability for the PostgreSQL instance. Can be either `ZONAL` or `REGIONAL`. | `string` | `"REGIONAL"` | no |
| <a name="input_backup_configuration"></a> [backup\_configuration](#input\_backup\_configuration) | The backup\_configuration settings subblock for the database setings | <pre>object({<br>    enabled                        = bool<br>    start_time                     = string<br>    location                       = string<br>    point_in_time_recovery_enabled = bool<br>    transaction_log_retention_days = string<br>    retained_backups               = number<br>    retention_unit                 = string<br>  })</pre> | <pre>{<br>  "binary_log_enabled": false,<br>  "enabled": true,<br>  "location": null,<br>  "point_in_time_recovery_enabled": false,<br>  "retained_backups": null,<br>  "retention_unit": null,<br>  "start_time": null,<br>  "transaction_log_retention_days": null<br>}</pre> | no |
| <a name="input_create_timeout"></a> [create\_timeout](#input\_create\_timeout) | The optional timout that is applied to limit long database creates. | `string` | `"30m"` | no |
| <a name="input_custom_instance_suffix"></a> [custom\_instance\_suffix](#input\_custom\_instance\_suffix) | Sets a custom suffix at the end of the Cloud SQL resource name | `string` | `""` | no |
| <a name="input_database_flags"></a> [database\_flags](#input\_database\_flags) | The database flags for the master instance. See [more details](https://cloud.google.com/sql/docs/postgres/flags) | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_database_version"></a> [database\_version](#input\_database\_version) | The database version to use | `string` | n/a | yes |
| <a name="input_delete_timeout"></a> [delete\_timeout](#input\_delete\_timeout) | The optional timout that is applied to limit long database deletes. | `string` | `"30m"` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Used to block Terraform from deleting a SQL Instance. | `bool` | `false` | no |
| <a name="input_disk_autoresize"></a> [disk\_autoresize](#input\_disk\_autoresize) | Configuration to increase storage size. | `bool` | `true` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | The disk size for the master instance. | `number` | `10` | no |
| <a name="input_disk_type"></a> [disk\_type](#input\_disk\_type) | The disk type for the master instance. | `string` | `"PD_SSD"` | no |
| <a name="input_encryption_key_name"></a> [encryption\_key\_name](#input\_encryption\_key\_name) | The full path to the encryption key used for the CMEK disk encryption | `string` | `null` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | `"sandpit"` | no |
| <a name="input_iam_user_emails"></a> [iam\_user\_emails](#input\_iam\_user\_emails) | A list of IAM users to be created in your cluster | `list(string)` | `[]` | no |
| <a name="input_insights_config"></a> [insights\_config](#input\_insights\_config) | The insights\_config settings for the database. | <pre>object({<br>    query_string_length     = number<br>    record_application_tags = bool<br>    record_client_address   = bool<br>  })</pre> | `null` | no |
| <a name="input_ip_configuration"></a> [ip\_configuration](#input\_ip\_configuration) | The ip configuration for the master instances. | <pre>object({<br>    private_network = string<br>    ipv4_enabled    = bool<br>    require_ssl     = bool<br>  })</pre> | <pre>{<br>  "ipv4_enabled": false,<br>  "private_network": "projects/cert-pr/global/networks/vpc-network",<br>  "require_ssl": true<br>}</pre> | no |
| <a name="input_maintenance_window_day"></a> [maintenance\_window\_day](#input\_maintenance\_window\_day) | The day of week (1-7) for the master instance maintenance. | `number` | `1` | no |
| <a name="input_maintenance_window_hour"></a> [maintenance\_window\_hour](#input\_maintenance\_window\_hour) | The hour of day (0-23) maintenance window for the master instance maintenance. | `number` | `23` | no |
| <a name="input_maintenance_window_update_track"></a> [maintenance\_window\_update\_track](#input\_maintenance\_window\_update\_track) | The update track of maintenance window for the master instance maintenance.Can be either `canary` or `stable`. | `string` | `"canary"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"master-instance"` | no |
| <a name="input_pricing_plan"></a> [pricing\_plan](#input\_pricing\_plan) | The pricing plan for the master instance. | `string` | `"PER_USE"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | n/a | `string` | `"cert-pr"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"australia-southeast1"` | no |
| <a name="input_tier"></a> [tier](#input\_tier) | The tier for the master instance. | `string` | `"db-custom-4-13312"` | no |
| <a name="input_update_timeout"></a> [update\_timeout](#input\_update\_timeout) | The optional timout that is applied to limit long database updates. | `string` | `"30m"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | The zone for the master instance, it should be something like: `us-central1-a`, `us-east1-c`. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_additional_users"></a> [additional\_users](#output\_additional\_users) | List of maps of additional users and passwords |
| <a name="output_current_project"></a> [current\_project](#output\_current\_project) | n/a |
| <a name="output_database_version"></a> [database\_version](#output\_database\_version) | n/a |
| <a name="output_instance_connection_name"></a> [instance\_connection\_name](#output\_instance\_connection\_name) | The connection name of the master instance to be used in connection strings |
| <a name="output_instance_first_ip_address"></a> [instance\_first\_ip\_address](#output\_instance\_first\_ip\_address) | The first IPv4 address of the addresses assigned. |
| <a name="output_instance_ip_address"></a> [instance\_ip\_address](#output\_instance\_ip\_address) | The IPv4 address assigned for the master instance |
| <a name="output_instance_name"></a> [instance\_name](#output\_instance\_name) | The instance name for the master instance |
| <a name="output_instance_self_link"></a> [instance\_self\_link](#output\_instance\_self\_link) | The URI of the master instance |
| <a name="output_instance_server_ca_cert"></a> [instance\_server\_ca\_cert](#output\_instance\_server\_ca\_cert) | The CA certificate information used to connect to the SQL instance via SSL |
| <a name="output_instance_service_account_email_address"></a> [instance\_service\_account\_email\_address](#output\_instance\_service\_account\_email\_address) | The service account email address assigned to the master instance |
| <a name="output_instances"></a> [instances](#output\_instances) | A list of all `google_sql_database_instance` resources we've created |
| <a name="output_primary"></a> [primary](#output\_primary) | The `google_sql_database_instance` resource representing the primary instance |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | The first private (PRIVATE) IPv4 address assigned for the master instance |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | n/a |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | The first public (PRIMARY) IPv4 address assigned for the master instance |
<!-- END_TF_DOCS -->

## Contributing

Refer to the [contribution guidelines](../README.md) for information on contributing to this module.