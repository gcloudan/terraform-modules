terraform {
  required_version = ">= 0.13"

  required_providers {
    google = {
      source = "hashicorp/google"
    }
    google-beta = {
      source = "hashicorp/google-beta"
    }
  }
  backend "gcs" {
    bucket      = "cert-pr"
    prefix      = "terraform/key-factory"
    credentials = "/Users/lobsterz/dev/me/terraform/terraform-sa.json"
  }
}
