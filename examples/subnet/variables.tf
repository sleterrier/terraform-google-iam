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

variable "project" {
  description = "The project where the subnet resides"
  default     = "project-1"
}

variable "region" {
  description = "The region where the subnet resides"
  default     = "us-west2"
}


/******************************************
  Subnet_iam_binding variables
 *****************************************/
variable "subnet_one" {
  description = "First subnet id to add the IAM policies/bindings"
  default     = "subnetid-1"
}

variable "subnet_two" {
  description = "Second subnet id to add the IAM policies/bindings"
  default     = "subnetid-2"
}

