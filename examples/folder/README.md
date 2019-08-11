# Folder example

## Usage
```hcl
module "folder-iam" {
  source  = "../../"
  folders = ["${var.folder_one}", "${var.folder_two}"]

  mode = "additive"

  bindings = {
    "roles/resourcemanager.folderEditor" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
    ]

    "roles/resourcemanager.folderViewer" = [
      "user:${var.user_email}",
    ]
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| folder\_one | The first folder ID to apply IAM bindings | string | `"folders/folder-1"` | no |
| folder\_two | The second folder ID to apply IAM bindings | string | `"folders/folder-2"` | no |
| group\_email | Email for group to receive roles \(ex. group@example.com\) | string | `"group@example.com"` | no |
| sa\_email | Email for Service Account to receive roles \(Ex. default-sa@example-project-id.iam.gserviceaccount.com\) | string | `"default-sa@example-project-id.iam.gserviceaccount.com"` | no |
| user\_email | Email for group to receive roles \(Ex. user@example.com\) | string | `"user@example.com"` | no |

