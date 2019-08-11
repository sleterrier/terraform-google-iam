/******************************************
  Locals configuration for module logic
 *****************************************/
locals {
  kms_key_rings_bindings_additive_pairs = flatten([
    for kms_key_ring in var.kms_key_rings: [
      for role, members in var.bindings: [
        for member in members: {
          kms_key_ring = kms_key_ring
          member       = member
          role         = role
        }
      ]
    ]
    if local.is_kms_key_rings_binding && local.is_additive
  ])

  kms_key_rings_bindings_additive = {
    for pair in local.kms_key_rings_bindings_additive_pairs:
      "${pair.kms_key_ring}__${pair.role}__${pair.member}" => pair
  }

  kms_key_rings_bindings_authoritative_pairs = flatten([
    for kms_key_ring in var.kms_key_rings: [
      for role, members in var.bindings: {
          kms_key_ring = kms_key_ring
          members      = members
          role         = role
      }
    ]
    if local.is_kms_key_rings_binding && local.is_authoritative
  ])

  kms_key_rings_bindings_authoritative = {
    for pair in local.kms_key_rings_bindings_authoritative_pairs:
      "${pair.kms_key_ring}__${pair.role}" => pair
  }
}

#/******************************************
#  Kms Key Ring IAM binding additive
# *****************************************/
resource "google_kms_key_ring_iam_member" "additive" {
  for_each = local.kms_key_rings_bindings_additive

  key_ring_id = each.value.kms_key_ring
  member      = each.value.member
  role        = each.value.role
}

/******************************************
  Kms Key Ring IAM binding authoritative
 *****************************************/
resource "google_kms_key_ring_iam_binding" "authoritative" {
  for_each = local.kms_key_rings_bindings_authoritative

  key_ring_id = each.value.kms_key_ring
  members     = each.value.members
  role        = each.value.role
}

