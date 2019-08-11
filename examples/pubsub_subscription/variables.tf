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

variable "pubsub_subscription_one" {
  description = "The first pubsub_subscription ID to apply IAM bindings"
  default     = "pubsub-subscription-1"
}

variable "pubsub_subscription_two" {
  description = "The second pubsub_subscription ID to apply IAM bindings"
  default     = "pubsub-subscription-2"
}

