Adding IAM users to cloud sql is a bit painful. Terraform has a google_service_account resource which gives easy access to the user's email. Unfortunately, IAM users need a stripped version of user email - per the docs:

This is postgres, user creation will not work 
// HA method using REGIONAL availability_type requires binary logs to be enabled



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
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_sql_database_instance.master](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance) | resource |
| [random_string.random_string_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"master-instance"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | n/a | `string` | `"cert-pr"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_version"></a> [database\_version](#output\_database\_version) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_self_link"></a> [self\_link](#output\_self\_link) | n/a |
<!-- END_TF_DOCS -->