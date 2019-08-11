# Storage Bucket example

## Usage
```hcl
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
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| storage_bucket\_one | The first storage_bucket ID to apply IAM bindings | string | `"storage-bucket-1"` | no |
| storage_bucket\_two | The second storage_bucket ID to apply IAM bindings | string | `"storage-bucket-2"` | no |
| group\_email | Email for group to receive roles \(ex. group@example.com\) | string | `"group@example.com"` | no |
| sa\_email | Email for Service Account to receive roles \(Ex. default-sa@example-project-id.iam.gserviceaccount.com\) | string | `"default-sa@example-project-id.iam.gserviceaccount.com"` | no |
| user\_email | Email for group to receive roles \(Ex. user@example.com\) | string | `"user@example.com"` | no |

