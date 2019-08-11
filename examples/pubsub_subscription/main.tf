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
module "pubsub_subscription-iam" {
  source  = "../../"

  mode                 = "additive"
  pubsub_subscriptions = [ "${var.pubsub_subscription_one}", "${var.pubsub_subscription_two}" ]

  bindings = {
    "roles/pubsub.viewer" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
    "roles/pubsub.editor" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
  }
}

