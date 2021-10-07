output "keys" {
  description = "Map of key name => key self link."
  value       = local.keys_by_name

  # The grants are important to the key be ready to use.
  depends_on = [
    google_kms_crypto_key_iam_binding.owners,
    google_kms_crypto_key_iam_binding.encrypters_decrypters
  ]
}