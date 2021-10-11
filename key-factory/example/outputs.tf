output "keyring_self_link" {
  value = module.kms-keyring.self_link
}

output "keyring_id" {
  value = module.kms-keyring.id
}

output "keyring_name" {
  value = module.kms-keyring.name
}

output "keys_self_link" {
  value = module.kms-keyring.keys
}

output "first_key_self_link" {
  value = module.kms-keyring.first_key_self_link
}