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
  Module pubsub_topic_iam_binding calling
 *****************************************/
module "pubsub_topic-iam" {
  source  = "../../"

  mode          = "additive"
  pubsub_topics = [ "${var.pubsub_topic_one}", "${var.pubsub_topic_two}" ]

  bindings = {
    "roles/pubsub.publisher" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
    "roles/pubsub.viewer" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
  }
}

