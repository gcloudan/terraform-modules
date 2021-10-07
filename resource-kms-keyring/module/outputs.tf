output "self_link" {
  value = data.google_kms_key_ring.existing_keyring == null ? join("", google_kms_key_ring.keyring.*.self_link) : data.google_kms_key_ring.existing_keyring.self_link
}

output "id" {
  value = data.google_kms_key_ring.existing_keyring == null ? join("", google_kms_key_ring.keyring.*.id) : data.google_kms_key_ring.existing_keyring.id
}

output "name" {
  value = data.google_kms_key_ring.existing_keyring == null ? join("", google_kms_key_ring.keyring.*.name) : data.google_kms_key_ring.existing_keyring.name
}