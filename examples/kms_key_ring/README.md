# KMS Key Ring example

## Usage
```hcl
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
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| kms_key_ring\_one | The first kms_key_ring ID to apply IAM bindings | string | `"kms_key_ring-1"` | no |
| kms_key_ring\_two | The second kms_key_ring ID to apply IAM bindings | string | `"kms_key_ring-2"` | no |
| group\_email | Email for group to receive roles \(ex. group@example.com\) | string | `"group@example.com"` | no |
| sa\_email | Email for Service Account to receive roles \(Ex. default-sa@example-project-id.iam.gserviceaccount.com\) | string | `"default-sa@example-project-id.iam.gserviceaccount.com"` | no |
| user\_email | Email for group to receive roles \(Ex. user@example.com\) | string | `"user@example.com"` | no |

