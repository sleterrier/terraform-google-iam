/******************************************
  Locals configuration for module logic
 *****************************************/
locals {
  storage_buckets_bindings_additive_pairs = flatten([
    for storage_bucket in var.storage_buckets: [
      for role, members in var.bindings: [
        for member in members: {
          member         = member
          role           = role
          storage_bucket = storage_bucket
        }
      ]
    ]
    if local.is_storage_buckets_binding && local.is_additive
  ])

  storage_buckets_bindings_additive = {
    for pair in local.storage_buckets_bindings_additive_pairs:
      "${pair.storage_bucket}__${pair.role}__${pair.member}" => pair
  }

  storage_buckets_bindings_authoritative_pairs = flatten([
    for storage_bucket in var.storage_buckets: [
      for role, members in var.bindings: {
          members        = members
          role           = role
          storage_bucket = storage_bucket
      }
    ]
    if local.is_storage_buckets_binding && local.is_authoritative
  ])

  storage_buckets_bindings_authoritative = {
    for pair in local.storage_buckets_bindings_authoritative_pairs:
      "${pair.storage_bucket}__${pair.role}" => pair
  }
}

/******************************************
  Folder IAM binding additive
 *****************************************/
resource "google_storage_bucket_iam_member" "additive" {
  for_each = local.storage_buckets_bindings_additive

  bucket = each.value.storage_bucket
  member = each.value.member
  role   = each.value.role
}

/******************************************
  Folder IAM binding authoritative
 *****************************************/
resource "google_storage_bucket_iam_binding" "authoritative" {
  for_each = local.storage_buckets_bindings_authoritative

  bucket  = each.value.storage_bucket
  members = each.value.members
  role    = each.value.role
}

