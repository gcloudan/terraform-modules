terraform {
  backend "gcs" {
    bucket      = "cert-pr"
    prefix      = "terraform/project_services"
    credentials = "../../terraform-sa.json"
  }
}

