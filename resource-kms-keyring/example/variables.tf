variable "region" {
  default = "australia-southeast1"
}

variable "project_id" {
  type    = string
  default = "cert-pr"
}

variable "activate_apis" {
  type = list
  default = [
    "cloudkms.googleapis.com"
  ]
}

