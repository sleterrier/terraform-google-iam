/******************************************
  Locals configuration for module logic
 *****************************************/
locals {
  pubsub_subscriptions_bindings_additive_pairs = flatten([
    for pubsub_subscription in var.pubsub_subscriptions: [
      for role, members in var.bindings: [
        for member in members: {
          member              = member
          pubsub_subscription = pubsub_subscription
          role                = role
        }
      ]
    ]
    if local.is_pubsub_subscriptions_binding && local.is_additive
  ])

  pubsub_subscriptions_bindings_additive = {
    for pair in local.pubsub_subscriptions_bindings_additive_pairs:
      "${pair.pubsub_subscription}__${pair.role}__${pair.member}" => pair
  }

  pubsub_subscriptions_bindings_authoritative_pairs = flatten([
    for pubsub_subscription in var.pubsub_subscriptions: [
      for role, members in var.bindings: {
          members             = members
          pubsub_subscription = pubsub_subscription
          role                = role
      }
    ]
    if local.is_pubsub_subscriptions_binding && local.is_authoritative
  ])

  pubsub_subscriptions_bindings_authoritative = {
    for pair in local.pubsub_subscriptions_bindings_authoritative_pairs:
      "${pair.pubsub_subscription}__${pair.role}" => pair
  }
}

/******************************************
  Pubsub subscription IAM binding additive
 *****************************************/
resource "google_pubsub_subscription_iam_member" "additive" {
  for_each = local.pubsub_subscriptions_bindings_additive

  member       = each.value.member
  project      = var.project
  role         = each.value.role
  subscription = each.value.var.pubsub_subscription
}

/******************************************
  Pubsub subscription IAM binding authoritative
 *****************************************/
resource "google_pubsub_subscription_iam_binding" "authoritative" {
  for_each = local.pubsub_subscriptions_bindings_authoritative

  members      = each.value.members
  project      = var.project
  role         = each.value.role
  subscription = each.value.var.pubsub_subscription
}

