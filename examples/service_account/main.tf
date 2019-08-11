/******************************************
  Provider configuration
 *****************************************/
provider "google" {
  version = "~> 2.7"
}

provider "google-beta" {
  version = "~> 2.7"
}

/******************************************
  Module service_account_iam_binding calling
 *****************************************/
module "service_account-iam" {
  source  = "../../"

  mode             = "additive"
  service_accounts = [ "${var.service_account_one}", "${var.service_account_two}" ]

  bindings = {
    "roles/iam.serviceAccountKeyAdmin" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
    "roles/iam.serviceAccountTokenCreator" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
  }
}

