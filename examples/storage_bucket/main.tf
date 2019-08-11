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
  Module storage_bucket_iam_binding calling
 *****************************************/
module "storage_bucket-iam" {
  source  = "../../"

  mode            = "additive"
  storage_buckets = [ "${var.storage_bucket_one}", "${var.storage_bucket_two}" ]

  bindings = {
    "roles/storage.legacyBucketReader" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
    "roles/storage.legacyBucketWriter" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
  }
}
