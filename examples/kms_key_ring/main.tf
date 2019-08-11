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
  Module kms_key_ring_iam_binding calling
 *****************************************/
module "kms_key_ring-iam" {
  source  = "../../"

  kms_key_rings = [ "${var.kms_key_ring_one}", "${var.kms_key_ring_two}" ]
  mode          = "authoritative"

  bindings = {
    "roles/cloudkms.cryptoKeyEncrypter" = [
      "user:${var.user_email}",
      "group:${var.group_email}",
    ]
    "roles/cloudkms.cryptoKeyDecrypter" = [
      "user:${var.user_email}",
      "group:${var.group_email}",
    ]
  }
}
