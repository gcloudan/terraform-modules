terraform {
  backend "gcs" {
    bucket      = "cert-pr"
    prefix      = "terraform/vpc"
    credentials = "/Users/lobsterz/dev/me/terraform/terraform-sa.json"
  }
}

