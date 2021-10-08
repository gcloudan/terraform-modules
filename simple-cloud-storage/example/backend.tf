terraform {
  backend "gcs" {
    bucket      = "cert-pr"
    prefix      = "terraform/simple-cloud-storage"
    credentials = "/Users/lobsterz/dev/me/terraform/terraform-sa.json"
  }
}

