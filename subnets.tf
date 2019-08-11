/******************************************
  Locals configuration for module logic
 *****************************************/
locals {
  subnets_bindings_additive_pairs = flatten([
    for subnet in var.subnets: [
      for role, members in var.bindings: [
        for member in members: {
          member = member
          role = role
          subnet = subnet
        }
      ]
    ]
    if local.is_subnets_binding && local.is_additive
  ])

  subnets_bindings_additive = {
    for pair in local.subnets_bindings_additive_pairs:
      "${pair.subnet}__${pair.role}__${pair.member}" => pair
  }

  subnets_bindings_authoritative_pairs = flatten([
    for subnet in var.subnets: [
      for role, members in var.bindings: {
          members = members
          role    = role
          subnet  = subnet
      }
    ]
    if local.is_subnets_binding && local.is_authoritative
  ])

  subnets_bindings_authoritative = {
    for pair in local.subnets_bindings_authoritative_pairs:
      "${pair.subnet}__${pair.role}" => pair
  }
}

/******************************************
  Subnet IAM binding additive
 *****************************************/
resource "google_compute_subnetwork_iam_member" "additive" {
  for_each = local.subnets_bindings_additive

  member     = each.value.member
  project    = element(split("/", each.value.subnet), 1)
  region     = element(split("/", each.value.subnet), 3)
  role       = each.value.role
  subnetwork = element(split("/", each.value.subnet), 5)
}

/******************************************
  Subnet IAM binding authoritative
 *****************************************/
resource "google_compute_subnetwork_iam_binding" "authoritative" {
  for_each = local.subnets_bindings_authoritative

  members    = each.value.members
  project    = element(split("/", each.value.subnet), 1)
  region     = element(split("/", each.value.subnet), 3)
  role       = each.value.role
  subnetwork = element(split("/", each.value.subnet), 5)
}

