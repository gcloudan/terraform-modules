variable "region" {
  default = "australia-southeast1"
}

variable "keyring_suffix" {
  description = "Suffix used to generate the keyring name."
  type        = string
  default     = "keyring"
}

variable "project_id" {
  type = string
}
variable "type" {
  # validation {
  #   condition     = contains(["shiba", "subnet", "vpc", "gcs", "bigquery", "cloudsql", "disk", "pubsub", "notebook", "ai"], var.type)
  #   error_message = "Error: Please seleect valid options from subnet, shiba, vpc, gcs, bigquery, cloudsql, disk, pubsub, notebook. ai."
  # }
}

variable "set_owners_for_keyring" {
  description = "Name of keyrings for which owners will be set."
  type        = bool
  default     = false
}

variable "owners" {
  description = "List of comma-separated owners for each keyring declared in set_owners_for."
  type        = string
  default     = ""
}

variable "encrypters_decrypters" {
  description = "List of comma-separated owners for each keyring declared in set_encrypters_decrypters_for_keyring."
  type        = string
  default     = ""
}

variable "set_encrypters_decrypters_for_keyring" {
  description = "Name of keyrings for which the encrypter/decrypters role will be set."
  type        = bool
  default     = false
}

# Keys

variable "keys" {
  description = "Key names."
  type        = list(string)
  default     = []
}

variable "keys_suffix" {
  description = "Suffix used to generate the key name."
  type        = string
  default     = ""
}

variable "set_keys_owners_for" {
  description = "Name of keys for which owners will be set."
  type        = list(string)
  default     = []
}

variable "keys_owners" {
  description = "List of comma-separated owners for each key declared in set_owners_for."
  type        = list(string)
  default     = []
}

variable "keys_encrypters_decrypters" {
  description = "List of comma-separated owners for each key declared in set_encrypters_decrypters_for."
  type        = list(string)
  default     = []
}

variable "set_keys_encrypters_decrypters_for" {
  description = "Name of keys for which the encrypter/decrypters role will be set."
  type        = list(string)
  default     = []
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

variable "env" {
  
}