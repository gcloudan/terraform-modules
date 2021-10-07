resource "random_id" "cmek_suffix" {
  byte_length = 2
}

resource "google_kms_crypto_key" "key" {
  name            = local.name
  key_ring        = data.google_kms_key_ring.existing_key_ring.self_link
  rotation_period = var.rotation_period

  purpose = var.purpose

  version_template {
    algorithm        = var.algorithm
    protection_level = var.protection_level
  }
}
