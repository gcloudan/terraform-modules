variable "region" {
  default = "australia-southeast1"
}

variable "project_id" {
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

variable "secondary_ip_cidr_range" {
  type = string
}

variable "machine_type" {
  type = string
}
variable "name" {
  type = string
}

variable "zone" {
}

variable "subnetwork_project" {
}

variable "subnetwork" {
}
