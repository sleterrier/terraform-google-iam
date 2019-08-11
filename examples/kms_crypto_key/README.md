# KMS Crypto Key example

## Usage
```hcl
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
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| kms_crypto_key\_one | The first kms_crypto_key ID to apply IAM bindings | string | `"kms-crypto-key-1"` | no |
| kms_crypto_key\_two | The second kms_crypto_key ID to apply IAM bindings | string | `"kms-crypto-key-2"` | no |
| group\_email | Email for group to receive roles \(ex. group@example.com\) | string | `"group@example.com"` | no |
| sa\_email | Email for Service Account to receive roles \(Ex. default-sa@example-project-id.iam.gserviceaccount.com\) | string | `"default-sa@example-project-id.iam.gserviceaccount.com"` | no |
| user\_email | Email for group to receive roles \(Ex. user@example.com\) | string | `"user@example.com"` | no |

