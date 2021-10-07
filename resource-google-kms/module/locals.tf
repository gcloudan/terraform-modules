locals {
  keys_by_name = zipmap(var.keys, slice(google_kms_crypto_key.key[*].self_link, 0, length(var.keys)) )
}