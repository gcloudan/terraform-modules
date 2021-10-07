terraform {
  required_version = ">= 0.13"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.87.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 3.87.0"
    }
    random = {
      ssource = "hashicorp/random"
      version = "~> 3.1.0"
    }
  }
  backend "gcs" {
    bucket      = "cert-pr"
    prefix      = "terraform/resource-google-kms"
    credentials = "/Users/lobsterz/dev/me/terraform/terraform-sa.json"
  }
}
