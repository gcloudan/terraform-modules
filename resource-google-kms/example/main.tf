module "key" {
  source = "../module"

  region     = var.region
  project_id = var.project_id
  env        = var.env
  suffix     = var.suffix

  key_ring_name = "disk_keyring"

  keys = [
    "key1",
    "key2"
  ]

  set_encrypters_decrypters_for = [
    "key1",
    "key2"
  ]
  encrypters_decrypters = [
    # "user:service-${data.google_project.current_project.number}@gcp-sa-pubsub.iam.gserviceaccount.com",
    "user:juelian.siow@kasna.com.au",
    "serviceAccount:service-${data.google_project.current_project.number}@compute-system.iam.gserviceaccount.com"
  ]

  set_owners_for = []
  owners         = []
}
