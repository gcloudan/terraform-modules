Replaced by  [key-factory](../key-factory/)

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_kms_key_ring.keyring](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring) | resource |
| [google_kms_key_ring_iam_binding.encrypters_decrypters](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring_iam_binding) | resource |
| [google_kms_key_ring_iam_binding.owners](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring_iam_binding) | resource |
| [null_resource.message](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [google_kms_key_ring.existing_keyring](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/kms_key_ring) | data source |
| [google_project.current_project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_encrypters_decrypters"></a> [encrypters\_decrypters](#input\_encrypters\_decrypters) | List of comma-separated owners for each keyring declared in set\_encrypters\_decrypters\_for. | `string` | `""` | no |
| <a name="input_owners"></a> [owners](#input\_owners) | List of comma-separated owners for each keyring declared in set\_owners\_for. | `string` | `"[]"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | n/a | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"australia-southeast1"` | no |
| <a name="input_set_encrypters_decrypters_for"></a> [set\_encrypters\_decrypters\_for](#input\_set\_encrypters\_decrypters\_for) | Name of keyrings for which the encrypter/decrypters role will be set. | `string` | `""` | no |
| <a name="input_set_owners_for"></a> [set\_owners\_for](#input\_set\_owners\_for) | Name of keyrings for which owners will be set. | `string` | `""` | no |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | Suffix used to generate the keyring name. | `string` | `"keyring"` | no |
| <a name="input_type"></a> [type](#input\_type) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_self_link"></a> [self\_link](#output\_self\_link) | n/a |
<!-- END_TF_DOCS -->