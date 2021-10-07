terraform {
  backend "gcs" {
    bucket      = "cert-pr"
    prefix      = "terraform/cloudsql"
    credentials = "/Users/lobsterz/dev/me/terraform/terraform-sa.json"
  }
}

