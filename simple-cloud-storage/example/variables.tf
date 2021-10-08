variable "activate_apis" {
  type = list
  default = [
    "storage.googleapis.com",
    "storage-api.googleapis.com"
  ]
}
variable "location" {
  default = "australia-southeast1"
}

variable "name" {
  description = "Names of the buckets to create."
  type        = string
  default     = "bucket1"
}

variable "project_id" {
  description = "The ID of the project in which to provision resources."
  type        = string
  default     = "cert-pr"
}