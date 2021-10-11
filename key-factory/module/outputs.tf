output "self_link" {
  description = "Self_link of Keyring."
  value = data.google_kms_key_ring.existing_keyring == null ? join("", google_kms_key_ring.keyring.*.self_link) : data.google_kms_key_ring.existing_keyring.self_link
}

output "id" {
  description = "ID of Keyring."
  value = data.google_kms_key_ring.existing_keyring == null ? join("", google_kms_key_ring.keyring.*.id) : data.google_kms_key_ring.existing_keyring.id
}

output "name" {
  description = "Name of Keyring."
  value = data.google_kms_key_ring.existing_keyring == null ? join("", google_kms_key_ring.keyring.*.name) : data.google_kms_key_ring.existing_keyring.name
}

output "keys" {
  description = "Map of key name => key self link."
  value       = local.keys_by_name

  # The grants are important to the key be ready to use.
  depends_on = [
    google_kms_crypto_key_iam_binding.keys_owners,
    google_kms_crypto_key_iam_binding.keys_encrypters_decrypters
  ]
}

output "first_key_self_link" {
  description = "First key self link."
  value       = google_kms_crypto_key.key[0].self_link
}