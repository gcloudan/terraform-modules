resource "google_kms_crypto_key_iam_member" "disk_key" {
  count         = var.key_ring_name == "disk_keyring" ? 1 : 0
  crypto_key_id = google_kms_crypto_key.key.self_link
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:service-${data.google_project.current_project.number}@compute-system.iam.gserviceaccount.com"
}

resource "google_kms_crypto_key_iam_member" "gcs_key" {
  count         = var.key_ring_name == "gcs_keyring" ? 1 : 0
  crypto_key_id = google_kms_crypto_key.key.self_link
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:service-${data.google_project.current_project.number}@gs-project-accounts.iam.gserviceaccount.com"
}

resource "google_kms_crypto_key_iam_member" "pubsub_key" {
  count         = var.key_ring_name == "pubsub_keyring" ? 1 : 0
  crypto_key_id = google_kms_crypto_key.key.self_link
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:service-${data.google_project.current_project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}
