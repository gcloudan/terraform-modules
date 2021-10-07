variable "region" {
  default = "australia-southeast1"
}

variable "project_id" {
  type    = string
  default = "cert-pr"
}

variable "ip_cidr_range" {
  type    = string
  default = "10.123.0.0/16"
}

variable "secondary_ip_cidr_range" {
  type    = string
  default = "192.168.0.0/16"
}

variable "auto_create_subnetworks" {
  default = false
}

variable "network_name" {
  default = "vpc-network"
}

variable "secondary_ip_range_name" {
  default = "secondary-range"
}

variable "subnetwork_name" {
  default = "test-subnet"
}

