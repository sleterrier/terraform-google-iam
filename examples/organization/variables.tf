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

variable "organization_one" {
  description = "The first organization ID to apply IAM bindings"
  default     = "123456789"
}

variable "organization_two" {
  description = "The second organization ID to apply IAM bindings"
  default     = "987654321"
}

