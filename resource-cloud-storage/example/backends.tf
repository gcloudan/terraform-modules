terraform {
  backend "gcs" {
    bucket      = "cert-pr"
    prefix      = "terraform/cloud-storage"
    credentials = "/Users/lobsterz/dev/me/terraform/terraform-sa.json"
  }
}

