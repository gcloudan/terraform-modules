module "key" {
  source = "../module"

  name       = var.name
  region     = var.region
  project_id = var.project_id

  key_ring_name = var.key_ring_name
}
