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

variable "folder_one" {
  description = "The first folder ID to apply IAM bindings"
  default     = "folders/folder-1"
}

variable "folder_two" {
  description = "The second folder ID to apply IAM bindings"
  default     = "folders/folder-2"
}

