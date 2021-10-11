variable "keys" {
  description = "Key names."
  type        = list(string)
  default     = []
}

variable "suffix" {
  description = "Suffix used to generate the key name."
  type        = string
  default     = ""
}

variable "set_owners_for" {
  description = "Name of keys for which owners will be set."
  type        = list(string)
  default     = []
}

variable "owners" {
  description = "List of comma-separated owners for each key declared in set_owners_for."
  type        = list(string)
  default     = []
}

variable "encrypters_decrypters" {
  description = "List of comma-separated owners for each key declared in set_encrypters_decrypters_for."
  type        = list(string)
  default     = []
}

variable "set_encrypters_decrypters_for" {
  description = "Name of keys for which the encrypter/decrypters role will be set."
  type        = list(string)
  default     = []
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

variable "env" {

}