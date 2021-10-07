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

variable "env" {
  default = "sandpit"
}
variable "names" {
  description = "Names of the buckets to create."
  type        = list(string)
  default     = ["bucket1", "bucket2"]
}

variable "project_id" {
  description = "The ID of the project in which to provision resources."
  type        = string
  default     = "cert-pr"
}

variable "prefix" {
  default = ""
}

variable "admins" {
  description = "IAM-style members who will be granted roles/storage.objectAdmin on all buckets."
  type        = list(string)
  default     = []
}

variable "creators" {
  description = "IAM-style members who will be granted roles/storage.objectCreators on all buckets."
  type        = list(string)
  default     = ["user:danny.tran@kasna.com.au"]
}

variable "viewers" {
  description = "IAM-style members who will be granted roles/storage.objectViewer on all buckets."
  type        = list(string)
  default     = []
}

variable "hmac_key_admins" {
  description = "IAM-style members who will be granted roles/storage.hmacKeyAdmin on all buckets."
  type        = list(string)
  default     = []
}

variable "storage_admins" {
  description = "IAM-style members who will be granted roles/storage.admin on all buckets."
  type        = list(string)
  default     = []
}

variable "bucket_admins" {
  description = "Map of lowercase unprefixed name => comma-delimited IAM-style per-bucket admins."
  type        = map(string)
  default = {
    bucket1 = "user:samuel.lin@kasna.com.au,user:danny.tran@kasna.com.au"
  }
}

variable "bucket_creators" {
  description = "Map of lowercase unprefixed name => comma-delimited IAM-style per-bucket creators."
  type        = map(string)
  default     = {}
}

variable "bucket_viewers" {
  description = "Map of lowercase unprefixed name => comma-delimited IAM-style per-bucket viewers."
  type        = map(string)
  default     = {}
}

variable "bucket_hmac_key_admins" {
  description = "Map of lowercase unprefixed name => comma-delimited IAM-style per-bucket HMAC Key admins."
  type        = map(string)
  default     = {}
}

variable "bucket_storage_admins" {
  description = "Map of lowercase unprefixed name => comma-delimited IAM-style per-bucket storage admins."
  type        = map(string)
  default = {
    bucket1 = "user:samuel.lin@kasna.com.au,user:danny.tran@kasna.com.au"
  }
}

variable "set_admin_roles" {
  description = "Grant roles/storage.objectAdmin role to admins and bucket_admins."
  type        = bool
  default     = true
}

variable "set_creator_roles" {
  description = "Grant roles/storage.objectCreator role to creators and bucket_creators."
  type        = bool
  default     = true
}

variable "set_viewer_roles" {
  description = "Grant roles/storage.objectViewer role to viewers and bucket_viewers."
  type        = bool
  default     = false
}

variable "set_hmac_key_admin_roles" {
  description = "Grant roles/storage.hmacKeyAdmin role to hmac_key_admins and bucket_hmac_key_admins."
  type        = bool
  default     = false
}

variable "set_storage_admin_roles" {
  description = "Grant roles/storage.admin role to storage_admins and bucket_storage_admins."
  type        = bool
  default     = true
}

variable "folders" {
  description = "Top level bucket folders. Map of lowercase unprefixed name => list of folders to create. Example: default = bucket1 = ['testfolder', 'testfolder2']"
  type        = map(list(string))
  default     = {}
}
