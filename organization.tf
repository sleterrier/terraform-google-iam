/******************************************
  Locals configuration for module logic
 *****************************************/
locals {
  orgs_bindings_additive_pairs = flatten([
    for org in var.organizations: [
      for role, members in var.bindings: [
        for member in members: {
          member = member
          org    = org
          role   = role
        }
      ]
    ]
    if local.is_orgs_binding && local.is_additive
  ])

  orgs_bindings_additive = {
    for pair in local.orgs_bindings_additive_pairs:
      "${pair.org}__${pair.role}__${pair.member}" => pair
  }

  orgs_bindings_authoritative_pairs = flatten([
    for org in var.organizations: [
      for role, members in var.bindings: {
          members = members
          org     = org
          role    = role
      }
    ]
    if local.is_orgs_binding && local.is_authoritative
  ])

  orgs_bindings_authoritative = {
    for pair in local.orgs_bindings_authoritative_pairs:
      "${pair.org}__${pair.role}" => pair
  }
}

/******************************************
  Organization IAM binding additive
 *****************************************/
resource "google_organization_iam_member" "additive" {
  for_each = local.orgs_bindings_additive

  member = each.value.member
  org_id = each.value.org
  role   = each.value.role
}

/******************************************
  Organization IAM binding authoritative
 *****************************************/
resource "google_organization_iam_binding" "authoritative" {
  for_each = local.orgs_bindings_authoritative

  members = each.value.members
  org_id  = each.value.org
  role    = each.value.role
}

