resource "random_id" "cmek_suffix" {
  count = length(var.keys)

  byte_length = 2
}

resource "google_kms_crypto_key" "key" {
  count = length(var.keys)

  name            = format("%s-%s-%s", var.keys[count.index], var.suffix == "" ? "${random_id.cmek_suffix[count.index].hex}" : "${var.suffix}", var.env)
  key_ring        = data.google_kms_key_ring.existing_key_ring.self_link
  rotation_period = var.rotation_period

  purpose = var.purpose

  version_template {
    algorithm        = var.algorithm
    protection_level = var.protection_level
  }
}

resource "google_kms_crypto_key_iam_binding" "owners" {
  count         = length(var.set_owners_for)
  role          = "roles/owner"
  crypto_key_id = local.keys_by_name[var.set_owners_for[count.index]]
  members       = compact(split(",", var.owners[count.index]))
}

resource "google_kms_crypto_key_iam_binding" "encrypters_decrypters" {
  count         = length(var.set_encrypters_decrypters_for)
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  crypto_key_id = local.keys_by_name[var.set_encrypters_decrypters_for[count.index]]
  members       = compact(split(",", var.encrypters_decrypters[count.index]))
}