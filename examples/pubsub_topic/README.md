# Pubsub Topic example

## Usage
```hcl
module "pubsub_topic-iam" {
  source  = "../../"

  mode          = "additive"
  pubsub_topics = [ "${var.pubsub_topic_one}", "${var.pubsub_topic_two}" ]

  bindings = {
    "roles/pubsub.publisher" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
      "user:${var.user_email}",
    ]
    "roles/pubsub.viewer" = [
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
| pubsub_topic\_one | The first pubsub_topic ID to apply IAM bindings | string | `"pubsub-topic-1"` | no |
| pubsub_topic\_two | The second pubsub_topic ID to apply IAM bindings | string | `"pubsub-topic-2"` | no |
| group\_email | Email for group to receive roles \(ex. group@example.com\) | string | `"group@example.com"` | no |
| sa\_email | Email for Service Account to receive roles \(Ex. default-sa@example-project-id.iam.gserviceaccount.com\) | string | `"default-sa@example-project-id.iam.gserviceaccount.com"` | no |
| user\_email | Email for group to receive roles \(Ex. user@example.com\) | string | `"user@example.com"` | no |

