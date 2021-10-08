terraform {
  backend "gcs" {
    bucket      = "cert-pr"
    prefix      = "terraform/key-factory"
    credentials = "/Users/lobsterz/dev/me/terraform/terraform-sa.json"
  }
}
