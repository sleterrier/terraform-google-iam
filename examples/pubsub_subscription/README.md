# Pubsub Subscription example

## Usage
```hcl
module "pubsub_subscription-iam" {
  source  = "../../"

  mode                 = "additive"
  pubsub_subscriptions = [ "${var.pubsub_subscription_one}", "${var.pubsub_subscription_two}" ]

  bindings = {
    "roles/pubsub.viewer" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
    "roles/pubsub.editor" = [
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
| pubsub_subscription\_one | The first pubsub_subscription ID to apply IAM bindings | string | `"pubsub-subscription-1"` | no |
| pubsub_subscription\_two | The second pubsub_subscription ID to apply IAM bindings | string | `"pubsub-subscription-2"` | no |
| group\_email | Email for group to receive roles \(ex. group@example.com\) | string | `"group@example.com"` | no |
| sa\_email | Email for Service Account to receive roles \(Ex. default-sa@example-project-id.iam.gserviceaccount.com\) | string | `"default-sa@example-project-id.iam.gserviceaccount.com"` | no |
| user\_email | Email for group to receive roles \(Ex. user@example.com\) | string | `"user@example.com"` | no |

