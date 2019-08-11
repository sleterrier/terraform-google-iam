# Subnet example
## Usage
```hcl
locals {
  subnet_one_full = format(
    "projects/%s/regions/%s/subnetworks/%s",
    var.project,
    var.region,
    var.subnet_one,
  )
  subnet_two_full = format(
    "projects/%s/regions/%s/subnetworks/%s",
    var.project,
    var.region,
    var.subnet_two,
  )
}

/******************************************
  Module subnet_iam_binding calling
 *****************************************/
module "subnet_iam_binding" {
  source = "../../"

  subnets = [local.subnet_one_full, local.subnet_two_full]

  mode = "additive"

  bindings = {
    "roles/compute.networkUser" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
    "roles/compute.networkViewer" = [
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
| group\_email | Email for group to receive roles \(ex. group@example.com\) | string | `"group@example.com"` | no |
| project | The project where the subnet resides | string | `"project-1"` | no |
| region | The region where the subnet resides | string | `"us-west2"` | no |
| sa\_email | Email for Service Account to receive roles \(Ex. default-sa@example-project-id.iam.gserviceaccount.com\) | string | `"default-sa@example-project-id.iam.gserviceaccount.com"` | no |
| subnet\_one | First subnet id to add the IAM policies/bindings | string | `"subnetid-1"` | no |
| subnet\_two | Second subnet id to add the IAM policies/bindings | string | `"subnetid-2"` | no |
| user\_email | Email for group to receive roles \(Ex. user@example.com\) | string | `"user@example.com"` | no |

## Caveats
The module expects the subnets to be provided fully qualified.  (ex: `projects/<project_id>/regions/<region>/subnetworks/<subnet_name>`)  This example takes your inputted project, region and subnets to form the fully qualified subnet ids.
