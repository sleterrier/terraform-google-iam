# Service Account example

## Usage
```hcl
module "service_account-iam" {
  source  = "../../"

  mode             = "additive"
  service_accounts = [ "${var.service_account_one}", "${var.service_account_two}" ]

  bindings = {
    "roles/iam.serviceAccountKeyAdmin" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
    "roles/iam.serviceAccountTokenCreator" = [
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
| service_account\_one | The first service_account ID to apply IAM bindings | string | `"service-account-1@project.iam.gserviceaccount.com"` | no |
| service_account\_two | The second service_account ID to apply IAM bindings | string | `"service-account-2@project.iam.gserviceaccount.com"` | no |
| group\_email | Email for group to receive roles \(ex. group@example.com\) | string | `"group@example.com"` | no |
| sa\_email | Email for Service Account to receive roles \(Ex. default-sa@example-project-id.iam.gserviceaccount.com\) | string | `"default-sa@example-project-id.iam.gserviceaccount.com"` | no |
| user\_email | Email for group to receive roles \(Ex. user@example.com\) | string | `"user@example.com"` | no |

