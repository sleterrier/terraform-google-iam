# Project example

## Usage
```hcl
module "project-iam" {
  source  = "../../"

  mode     = "additive"
  projects = [ "${var.project_one}", "${var.project_two}" ]

  bindings = {
    "roles/compute.networkAdmin" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
    "roles/appengine.appAdmin" = [
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
| project\_one | The first project ID to apply IAM bindings | string | `"project-1"` | no |
| project\_two | The second project ID to apply IAM bindings | string | `"project-2"` | no |
| group\_email | Email for group to receive roles \(ex. group@example.com\) | string | `"group@example.com"` | no |
| sa\_email | Email for Service Account to receive roles \(Ex. default-sa@example-project-id.iam.gserviceaccount.com\) | string | `"default-sa@example-project-id.iam.gserviceaccount.com"` | no |
| user\_email | Email for group to receive roles \(Ex. user@example.com\) | string | `"user@example.com"` | no |

