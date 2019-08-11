variable "group_email" {
  description = "Email for group to receive roles (ex. group@example.com)"
  default     = "group@example.com"
}

variable "sa_email" {
  description = "Email for Service Account to receive roles (Ex. default-sa@example-project-id.iam.gserviceaccount.com)"
  default     = "default-sa@example-project-id.iam.gserviceaccount.com"
}

variable "user_email" {
  description = "Email for group to receive roles (Ex. user@example.com)"
  default     = "user@example.com"
}

variable "storage_bucket_one" {
  description = "The first storage_bucket ID to apply IAM bindings"
  default     = "storage-bucket-1"
}

variable "storage_bucket_two" {
  description = "The second storage_bucket ID to apply IAM bindings"
  default     = "storage-bucket-2"
}

