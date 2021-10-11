resource "google_kms_key_ring" "keyring" {
  count = data.google_kms_key_ring.existing_keyring.self_link == null ? 1 : 0

  name     = format("%s_%s", var.type, var.suffix)
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
  role        = "roles/owner"
  key_ring_id = data.google_kms_key_ring.existing_keyring.self_link == null ? join("", google_kms_key_ring.keyring.*.id) : data.google_kms_key_ring.existing_keyring.self_link
  members     = compact(split(",", var.owners))
}

resource "google_kms_key_ring_iam_binding" "encrypters_decrypters" {
  role        = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  key_ring_id = data.google_kms_key_ring.existing_keyring.self_link == null ? join("", google_kms_key_ring.keyring.*.id) : data.google_kms_key_ring.existing_keyring.self_link
  members     = compact(split(",", var.encrypters_decrypters))
}