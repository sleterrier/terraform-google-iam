/******************************************
  Locals configuration for module logic
 *****************************************/
locals {
  service_accounts_bindings_additive_pairs = flatten([
    for service_account in var.service_accounts: [
      for role, members in var.bindings: [
        for member in members: {
          member          = member
          role            = role
          service_account = service_account
        }
      ]
    ]
    if local.is_service_accounts_binding && local.is_additive
  ])

  service_accounts_bindings_additive = {
    for pair in local.service_accounts_bindings_additive_pairs:
      "${pair.service_account}__${pair.role}__${pair.member}" => pair
  }

  service_accounts_bindings_authoritative_pairs = flatten([
    for service_account in var.service_accounts: [
      for role, members in var.bindings: {
          members         = members
          role            = role
          service_account = service_account
      }
    ]
    if local.is_service_accounts_binding && local.is_authoritative
  ])

  service_accounts_bindings_authoritative = {
    for pair in local.service_accounts_bindings_authoritative_pairs:
      "${pair.service_account}__${pair.role}" => pair
  }
}

/******************************************
  Service Account IAM binding additive
 *****************************************/
resource "google_service_account_iam_member" "additive" {
    for_each = local.service_accounts_bindings_additive

    member             = each.value.member
    role               = each.value.role
    service_account_id = each.value.service_account
}

/******************************************
  Service Account IAM binding authoritative
 *****************************************/
resource "google_service_account_iam_binding" "authoritative" {
    for_each = local.service_accounts_bindings_authoritative

    members            = each.value.members
    role               = each.value.role
    service_account_id = each.value.service_account
}

