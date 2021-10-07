variable "region" {
  type    = string
  default = "australia-southeast1"
}

variable "project_id" {
  type    = string
  default = "cert-pr"
}

variable "activate_apis" {
  type = list
  default = [
    "compute.googleapis.com",
    "iam.googleapis.com",
    "sqladmin.googleapis.com"
  ]
}
