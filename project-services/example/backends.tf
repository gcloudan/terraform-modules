terraform {
  backend "gcs" {
    bucket      = "cert-pr"
    prefix      = "terraform/project-services"
    credentials = "/Users/lobsterz/dev/me/terraform/terraform-sa.json"
  }
}

