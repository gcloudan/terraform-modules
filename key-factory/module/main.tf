resource "random_id" "cmek_suffix" {
  count = length(var.keys)

  byte_length = 2
}

resource "google_kms_key_ring" "keyring" {
  count = data.google_kms_key_ring.existing_keyring.self_link == null ? 1 : 0

  name     = format("%s_%s", var.type, var.keyring_suffix)
  location = var.region
  project  = var.project_id
  depends_on = [
    data.google_kms_key_ring.existing_keyring
  ]
}

resource "null_resource" "message" {
  count = data.google_kms_key_ring.existing_keyring.self_link == null ? 0 : 1

  provisioner "local-exec" {
    command = <<-EOT
    echo -e "\e[1;31m NOTE: \e[0m \e[1;32m KMS Keyring already exists, not creating the resource, instead fetching the data as an output for you to use (refer to example)\e[0m"
    EOT
  }
}

resource "google_kms_key_ring_iam_binding" "owners" {
  count       = var.set_owners_for_keyring ? 1 : 0
  role        = "roles/owner"
  key_ring_id = data.google_kms_key_ring.existing_keyring.self_link == null ? google_kms_key_ring.keyring[0].id : data.google_kms_key_ring.existing_keyring.self_link
  members     = compact(split(",", var.owners))
}

resource "google_kms_key_ring_iam_binding" "encrypters_decrypters" {
  count       = var.set_encrypters_decrypters_for_keyring ? 1 : 0
  role        = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  key_ring_id = data.google_kms_key_ring.existing_keyring.self_link == null ? google_kms_key_ring.keyring[0].id : data.google_kms_key_ring.existing_keyring.self_link
  members     = compact(split(",", var.encrypters_decrypters))
}


resource "google_kms_crypto_key" "key" {
  count = length(var.keys)

  name            = format("%s-%s-%s", var.keys[count.index], var.keys_suffix == "" ? "${random_id.cmek_suffix[count.index].hex}" : "${var.keys_suffix}", var.env)
  key_ring        = data.google_kms_key_ring.existing_keyring.self_link == null ? google_kms_key_ring.keyring[0].id : data.google_kms_key_ring.existing_keyring.self_link
  rotation_period = var.rotation_period

  purpose = var.purpose

  version_template {
    algorithm        = var.algorithm
    protection_level = var.protection_level
  }
}

resource "google_kms_crypto_key_iam_binding" "keys_owners" {
  count         = length(var.set_keys_owners_for)
  role          = "roles/owner"
  crypto_key_id = local.keys_by_name[var.set_keys_owners_for[count.index]]
  members       = compact(split(",", var.keys_owners[count.index]))
}

resource "google_kms_crypto_key_iam_binding" "keys_encrypters_decrypters" {
  count         = length(var.set_keys_encrypters_decrypters_for)
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  crypto_key_id = local.keys_by_name[var.set_keys_encrypters_decrypters_for[count.index]]
  members       = compact(split(",", var.keys_encrypters_decrypters[count.index]))
}