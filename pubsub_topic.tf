/******************************************
  Locals configuration for module logic
 *****************************************/
locals {
  pubsub_topics_bindings_additive_pairs = flatten([
    for pubsub_topic in var.pubsub_topics: [
      for role, members in var.bindings: [
        for member in members: {
          member       = member
          pubsub_topic = pubsub_topic
          role         = role
        }
      ]
    ]
    if local.is_pubsub_topics_binding && local.is_additive
  ])

  pubsub_topics_bindings_additive = {
    for pair in local.pubsub_topics_bindings_additive_pairs:
      "${pair.pubsub_topic}__${pair.role}__${pair.member}" => pair
  }

  pubsub_topics_bindings_authoritative_pairs = flatten([
    for pubsub_topic in var.pubsub_topics: [
      for role, members in var.bindings: {
          members      = members
          pubsub_topic = pubsub_topic
          role         = role
      }
    ]
    if local.is_pubsub_topics_binding && local.is_authoritative
  ])

  pubsub_topics_bindings_authoritative = {
    for pair in local.pubsub_topics_bindings_authoritative_pairs:
      "${pair.pubsub_topic}__${pair.role}" => pair
  }
}

/******************************************
  Pubsub topic IAM binding additive
 *****************************************/
resource "google_pubsub_topic_iam_member" "additive" {
    for_each = local.pubsub_topics_bindings_additive

    member  = each.value.member
    project = var.project
    role    = each.value.role
    topic   = each.value.pubsub_topic
}

/******************************************
  Pubsub topic IAM binding authoritative
 *****************************************/
resource "google_pubsub_topic_iam_binding" "authoritative" {
    for_each = local.pubsub_topics_bindings_authoritative

    members = each.value.members
    project = var.project
    role    = each.value.role
    topic   = each.value.pubsub_topic
}

