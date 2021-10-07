variable "region" {
  default = "australia-southeast1"
}

variable "suffix" {
  description = "Suffix used to generate the keyring name."
  type        = string
  default     = "keyring"
}

variable "project_id" {
  type = string
}
variable "type" {
  validation {
    condition     = contains(["gcs", "bigquery", "cloudsql", "disk", "pubsub", "notebook"], var.type)
    error_message = "Error: Please seleect valid options from gcs, bigquery, cloudsql, disk, pubsub, notebook."
  }
}

variable "set_owners_for" {
  description = "Name of keyrings for which owners will be set."
  type        = list(string)
  default     = []
}

variable "owners" {
  description = "List of comma-separated owners for each keyring declared in set_owners_for."
  type        = list(string)
  default     = []
}

variable "encrypters_decrypters" {
  description = "List of comma-separated owners for each keyring declared in set_encrypters_decrypters_for."
  type        = list(string)
  default     = []
}

variable "set_encrypters_decrypters_for" {
  description = "Name of keyrings for which the encrypter/decrypters role will be set."
  type        = list(string)
  default     = []
}
