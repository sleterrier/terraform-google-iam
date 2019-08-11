# GCP IAM bindings Terraform Module

This Terraform module makes it easier to non-destructively manage multiple IAM roles for resources on Google Cloud Platform.

Disclaimer: this module is a for_each re-write of [terraform-google-iam](https://github.com/terraform-google-modules/terraform-google-iam). Only Organizations, Folders and Projects bindings have been fully tested so far.

## Compatibility

This module is meant for use with Terraform >= 0.12.6. If you haven't [upgraded](https://www.terraform.io/upgrade-guides/0-12.html) and need a Terraform 0.11.x-compatible version of this module, you're out of luck!

## Usage

Full examples are in the [examples](./examples/) folder, but basic usage is as follows for managing roles on two projects:

```hcl
module "iam_binding" {
  source = "../modules/gcp-iam-binding"

  projects = ["project-123456", "project-9876543"]

  bindings = {
    "roles/storage.admin" = [
      "group:test_sa_group@test.com",
      "user:someone@google.com",
    ]

    "roles/compute.networkAdmin" = [
      "group:test_sa_group@test.com",
      "user:someone@google.com",
    ]

    "roles/compute.imageUser" = [
      "user:someone@google.com",
    ]
  }
}
```

The module also offers an **authoritative** mode which will remove all roles not assigned through Terraform. This is an example of using the authoritative mode to manage access to a storage bucket:

```hcl
module "storage_buckets_iam_binding" {
  source          = "../modules/gcp-iam-binding"
  storage_buckets = [ "my-storage-bucket" ]

  mode = "authoritative"

  bindings = {
    "roles/storage.legacyBucketReader" = [
      "user:user1@google.com",
      "group:group1@test.com",
    ]

    "roles/storage.legacyBucketWriter" = [
      "user:user1@google.com",
      "group:group1@test.com",
    ]
  }
}
```

### Variables

Following variables are the most important to control module's behavior:

- Mode
    This variable controls the module's behavior, by default is set to "additive", possible options are:
      - additive: add members to role, old members are not deleted from this role.
      - authoritative: set the role's members, other roles' members are not deleted.

- Bindings
  Is a map of role (key) and list of members (value) with member type prefix, for example:

```hcl
bindings = {
  "roles/<some_role>" = [
    "user:user1@somewhere.com",
    "group:group1@somewhereelse.com"
  ]
}
```

- Project
  It is only used for the following resources:
  - `service_accounts`
  - `pubsub_topics`
  - `pubsub_subscriptions`

#### Additive and Authoritative Modes

This module includes two modes: additive and authoritative.

In authoritative mode, the module takes full control over the IAM bindings listed in the module. This means that any members added to roles outside the module will be removed the next time Terraform runs. However, roles not listed in the module will be unaffected.

In additive mode, this module leaves existing bindings unaffected. Instead, any members listed in the module will be added to the existing set of IAM bindings. However, members listed in the module *are* fully controlled by the module. This means that if you add a binding via the module and later remove it, the module will correctly handle removing the role binding.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bindings | Map of role (key) and list of members (value) to add the IAM policies/bindings to | map | n/a | yes |
| folders | Folders list to add the IAM policies/bindings to | list(string) | `<list>` | no |
| kms\_crypto\_keys | Kms Crypto Key list to add the IAM policies/bindings to | list(string) | `<list>` | no |
| kms\_key\_rings | Kms Key Rings list to add the IAM policies/bindings to | list(string) | `<list>` | no |
| mode | Mode for adding the IAM policies/bindings, additive and authoritative | string | `"additive"` | no |
| organizations | Organizations list to add the IAM policies/bindings to | list | `<list>` | no |
| project | Project to add the IAM policies/bindings to | string | `""` | no |
| projects | Projects list to add the IAM policies/bindings to | list(string) | `<list>` | no |
| pubsub\_subscriptions | Pubsub subscriptions list to add the IAM policies/bindings to | list(string) | `<list>` | no |
| pubsub\_topics | Pubsub topics list to add the IAM policies/bindings to | list(string) | `<list>` | no |
| service\_accounts | Service Accounts list to add the IAM policies/bindings to | list(string) | `<list>` | no |
| storage\_buckets | Buckets list to add the IAM policies/bindings to | list(string) | `<list>` | no |
| subnets | Subnets list to add the IAM policies/bindings to | list(string) | `<list>` | no |

## IAM Bindings

You can choose one of the following resource types for applying the IAM bindings to:

- Projects (`projects` variable)
- Organizations(`organizations` variable)
- Folders (`folders` variable)
- Service Accounts (`service_accounts` variable)
- Subnetworks (`subnets` variable)
- Storage buckets (`storage_buckets` variable)
- Pubsub topics (`pubsub_topics` variable)
- Pubsub subscriptions (`pubsub_subscriptions` variable)
- Kms Key Rings (`kms_key_rings` variable)
- Kms Crypto Keys (`kms_crypto_keys` variable)

Set the specified variable on the module call to choose the resources to affect. Remember to set the `mode` [variable](#variables) and give enough [permissions](#permissions) to manage the selected resource as well.

## Requirements

### Terraform plugins

- [Terraform](https://www.terraform.io/downloads.html) 0.12.6
- [terraform-provider-google](https://github.com/terraform-providers/terraform-provider-google) 2.5
- [terraform-provider-google-beta](https://github.com/terraform-providers/terraform-provider-google-beta) 2.5

### Permissions

In order to execute this module you must have a Service Account with an appropriate role to manage IAM for the applicable resource. The appropriate role differs depending on which resource you are targeting, as follows:

- Organization:
  - Organization Administrator: Access to administer all resources belonging to the organization
    and does not include privileges for billing or organization role administration.
  - Custom: Add resourcemanager.organizations.getIamPolicy and
    resourcemanager.organizations.setIamPolicy permissions.
- Project:
  - Owner: Full access and all permissions for all resources of the project.
  - Projects IAM Admin: allows users to administer IAM policies on projects.
  - Custom: Add resourcemanager.projects.getIamPolicy and resourcemanager.projects.setIamPolicy permissions.
- Folder:
  - The Folder Admin: All available folder permissions.
  - Folder IAM Admin: Allows users to administer IAM policies on folders.
  - Custom: Add resourcemanager.folders.getIamPolicy and
    resourcemanager.folders.setIamPolicy permissions (must be added in the organization).
- Service Account:
  - Service Account Admin: Create and manage service accounts.
  - Custom: Add resourcemanager.organizations.getIamPolicy and
    resourcemanager.organizations.setIamPolicy permissions.
- Subnetwork:
  - Project compute admin: Full control of Compute Engine resources.
  - Project compute network admin: Full control of Compute Engine networking resources.
  - Project custom: Add compute.subnetworks.getIamPolicy	and
    compute.subnetworks..setIamPolicy permissions.
- Storage bucket:
  - Storage Admin: Full control of GCS resources.
  - Storage Legacy Bucket Owner: Read and write access to existing
    buckets with object listing/creation/deletion.
  - Custom: Add storage.buckets.getIamPolicy	and
  storage.buckets.setIamPolicy permissions.
- Pubsub topic:
  - Pub/Sub Admin: Create and manage service accounts.
  - Custom: Add pubsub.topics.getIamPolicy and pubsub.topics.setIamPolicy permissions.
- Pubsub subscription:
  - Pub/Sub Admin role: Create and manage service accounts.
  - Custom role: Add pubsub.subscriptions.getIamPolicy and
    pubsub.subscriptions.setIamPolicy permissions.
- Kms Key Ring:
  - Owner: Full access to all resources.
  - Cloud KMS Admin: Enables management of crypto resources.
  - Custom: Add cloudkms.keyRings.getIamPolicy and cloudkms.keyRings.getIamPolicy permissions.
- Kms Crypto Key:
  - Owner: Full access to all resources.
  - Cloud KMS Admin: Enables management of cryptoresources.
  - Custom: Add cloudkms.cryptoKeys.getIamPolicy	and cloudkms.cryptoKeys.setIamPolicy permissions.

