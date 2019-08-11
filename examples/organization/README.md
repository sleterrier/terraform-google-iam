# Organization example

## Usage
```hcl
module "organization-iam" {
  source  = "../../"

  mode = "additive"
  organizations = [ "${var.organization_one}", "${var.organization_two}" ]

  bindings = {
    "roles/resourcemanager.organizationViewer" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
    "roles/resourcemanager.projectDeleter" = [
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
| organization\_one | The first organization ID to apply IAM bindings | string | `"123456789"` | no |
| organization\_two | The second organization ID to apply IAM bindings | string | `"987654321"` | no |
| group\_email | Email for group to receive roles \(ex. group@example.com\) | string | `"group@example.com"` | no |
| sa\_email | Email for Service Account to receive roles \(Ex. default-sa@example-project-id.iam.gserviceaccount.com\) | string | `"default-sa@example-project-id.iam.gserviceaccount.com"` | no |
| user\_email | Email for group to receive roles \(Ex. user@example.com\) | string | `"user@example.com"` | no |

