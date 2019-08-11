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
  Module organization_iam_binding calling
 *****************************************/
module "organization-iam" {
  source  = "../../"

  mode = "additive"
  organizations = [ "${var.organization_one}", "${var.organization_two}" ]

  bindings = {
    "roles/resourcemanager.organizationViewer" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
    "roles/resourcemanager.projectDeleter" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
  }
}
