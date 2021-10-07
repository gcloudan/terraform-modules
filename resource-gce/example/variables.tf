variable "region" {
  default = "australia-southeast1"
}

variable "project_id" {
  type = string
}

variable "zone" {
  type = string
}

variable "tags" {
  type = list(string)
}
variable "labels" {
  type = map(string)
}

variable "ip_cidr_range" {
  type = string
}

variable "subnetwork" {
  type = string
}

variable "secondary_ip_cidr_range" {
  type = string
}

variable "machine_type" {
  type = string
}
variable "name" {
  type = string
}

variable "subnetwork_project" {
}

variable "activate_apis" {
  type = list
  default = [
    "compute.googleapis.com",
    "iam.googleapis.com",
    "sqladmin.googleapis.com",
    "cloudbilling.googleapis.com",
    "resourceviews.googleapis.com",
    "replicapool.googleapis.com"
  ]
}
