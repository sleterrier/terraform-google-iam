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
  Module kms_crypto_key_iam_binding calling
 *****************************************/
module "kms_crypto_key-iam" {
  source  = "../../"

  kms_crypto_keys = [ "${var.kms_crypto_key_one}", "${var.kms_crypto_key_two}" ]
  mode            = "authoritative"

  bindings = {
    "roles/cloudkms.cryptoKeyEncrypter" = [
      "user:${var.user_email}",
      "group:${var.group_email}",
      "serviceAccount:${var.sa_email}",
    ]
    "roles/cloudkms.cryptoKeyDecrypter" = [
      "user:${var.user_email}",
      "group:${var.group_email}",
    ]
  }
}
