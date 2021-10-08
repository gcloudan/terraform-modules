<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_kms_crypto_key.key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key) | resource |
| [google_kms_crypto_key_iam_binding.keys_encrypters_decrypters](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key_iam_binding) | resource |
| [google_kms_crypto_key_iam_binding.keys_owners](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key_iam_binding) | resource |
| [google_kms_key_ring.keyring](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring) | resource |
| [google_kms_key_ring_iam_binding.encrypters_decrypters](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring_iam_binding) | resource |
| [google_kms_key_ring_iam_binding.owners](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring_iam_binding) | resource |
| [null_resource.message](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_id.cmek_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [google_kms_key_ring.existing_keyring](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/kms_key_ring) | data source |
| [google_project.current_project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_algorithm"></a> [algorithm](#input\_algorithm) | n/a | `string` | `"GOOGLE_SYMMETRIC_ENCRYPTION"` | no |
| <a name="input_encrypters_decrypters"></a> [encrypters\_decrypters](#input\_encrypters\_decrypters) | List of comma-separated owners for each keyring declared in set\_encrypters\_decrypters\_for\_keyring. | `string` | `""` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `any` | n/a | yes |
| <a name="input_keyring_suffix"></a> [keyring\_suffix](#input\_keyring\_suffix) | Suffix used to generate the keyring name. | `string` | `"keyring"` | no |
| <a name="input_keys"></a> [keys](#input\_keys) | Key names. | `list(string)` | `[]` | no |
| <a name="input_keys_encrypters_decrypters"></a> [keys\_encrypters\_decrypters](#input\_keys\_encrypters\_decrypters) | List of comma-separated owners for each key declared in set\_encrypters\_decrypters\_for. | `list(string)` | `[]` | no |
| <a name="input_keys_owners"></a> [keys\_owners](#input\_keys\_owners) | List of comma-separated owners for each key declared in set\_owners\_for. | `list(string)` | `[]` | no |
| <a name="input_keys_suffix"></a> [keys\_suffix](#input\_keys\_suffix) | Suffix used to generate the key name. | `string` | `""` | no |
| <a name="input_owners"></a> [owners](#input\_owners) | List of comma-separated owners for each keyring declared in set\_owners\_for. | `string` | `""` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | n/a | `string` | n/a | yes |
| <a name="input_protection_level"></a> [protection\_level](#input\_protection\_level) | n/a | `string` | `"SOFTWARE"` | no |
| <a name="input_purpose"></a> [purpose](#input\_purpose) | n/a | `string` | `"ENCRYPT_DECRYPT"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"australia-southeast1"` | no |
| <a name="input_rotation_period"></a> [rotation\_period](#input\_rotation\_period) | n/a | `string` | `"31560000s"` | no |
| <a name="input_set_encrypters_decrypters_for_keyring"></a> [set\_encrypters\_decrypters\_for\_keyring](#input\_set\_encrypters\_decrypters\_for\_keyring) | Name of keyrings for which the encrypter/decrypters role will be set. | `bool` | `false` | no |
| <a name="input_set_keys_encrypters_decrypters_for"></a> [set\_keys\_encrypters\_decrypters\_for](#input\_set\_keys\_encrypters\_decrypters\_for) | Name of keys for which the encrypter/decrypters role will be set. | `list(string)` | `[]` | no |
| <a name="input_set_keys_owners_for"></a> [set\_keys\_owners\_for](#input\_set\_keys\_owners\_for) | Name of keys for which owners will be set. | `list(string)` | `[]` | no |
| <a name="input_set_owners_for_keyring"></a> [set\_owners\_for\_keyring](#input\_set\_owners\_for\_keyring) | Name of keyrings for which owners will be set. | `bool` | `false` | no |
| <a name="input_type"></a> [type](#input\_type) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | ID of Keyring. |
| <a name="output_keys"></a> [keys](#output\_keys) | Map of key name => key self link. |
| <a name="output_name"></a> [name](#output\_name) | Name of Keyring. |
| <a name="output_self_link"></a> [self\_link](#output\_self\_link) | Self\_link of Keyring. |
<!-- END_TF_DOCS -->