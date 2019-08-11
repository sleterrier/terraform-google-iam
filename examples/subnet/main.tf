locals {
  subnet_one_full = format(
    "projects/%s/regions/%s/subnetworks/%s",
    var.project,
    var.region,
    var.subnet_one,
  )
  subnet_two_full = format(
    "projects/%s/regions/%s/subnetworks/%s",
    var.project,
    var.region,
    var.subnet_two,
  )
}

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
  Module pubsub_subscription_iam_binding calling
 *****************************************/
module "subnet_iam_binding" {
  source = "../../"

  subnets = [local.subnet_one_full, local.subnet_two_full]

  mode = "additive"

  bindings = {
    "roles/compute.networkUser" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
    "roles/compute.networkViewer" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
  }
}

