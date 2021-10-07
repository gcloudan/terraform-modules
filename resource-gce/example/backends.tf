terraform {
  backend "gcs" {
    bucket      = "cert-pr"
    prefix      = "terraform/gce"
    credentials = "/Users/lobsterz/dev/me/terraform/terraform-sa.json"
  }
}

