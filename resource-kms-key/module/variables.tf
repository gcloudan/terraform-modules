variable "name" {

}

variable "project_id" {

}

variable "region" {

}

variable "rotation_period" {
  default = "31560000s"
}

variable "purpose" {
  default = "ENCRYPT_DECRYPT"
}

variable "algorithm" {
  default = "GOOGLE_SYMMETRIC_ENCRYPTION"
}

variable "protection_level" {
  default = "SOFTWARE"
}

variable "key_ring_name" {

}