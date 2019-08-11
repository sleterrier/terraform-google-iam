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

variable "kms_crypto_key_one" {
  description = "The first kms_crypto_key ID to apply IAM bindings"
  default     = "kms-crypto-key-1"
}

variable "kms_crypto_key_two" {
  description = "The second kms_crypto_key ID to apply IAM bindings"
  default     = "kms-crypto-key-2"
}

