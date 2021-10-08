output "keyring_self_link" {
  value = module.kms-keyring.self_link
}

output "keys_self_link" {
  value = module.kms-keyring.keys
}
