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

variable "service_account_one" {
  description = "The first service_account ID to apply IAM bindings"
  default     = "service-account-1@project.iam.gserviceaccount.com"
}

variable "service_account_two" {
  description = "The second service_account ID to apply IAM bindings"
  default     = "service-account-2@project.iam.gserviceaccount.com"
}

