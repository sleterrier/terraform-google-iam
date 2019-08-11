/******************************************
  Locals configuration for module logic
 *****************************************/
locals {
  projects_bindings_additive_pairs = flatten([
    for project in var.projects: [
      for role, members in var.bindings: [
        for member in members: {
          member  = member
          project = project
          role    = role
        }
      ]
    ]
    if local.is_projects_binding && local.is_additive
  ])

  projects_bindings_additive = {
    for pair in local.projects_bindings_additive_pairs:
      "${pair.project}__${pair.role}__${pair.member}" => pair
  }

  projects_bindings_authoritative_pairs = flatten([
    for project in var.projects: [
      for role, members in var.bindings: {
          members = members
          project = project
          role    = role
      }
    ]
    if local.is_projects_binding && local.is_authoritative
  ])

  projects_bindings_authoritative = {
    for pair in local.projects_bindings_authoritative_pairs:
      "${pair.project}__${pair.role}" => pair
  }
}

/******************************************
  Project IAM binding additive
 *****************************************/
resource "google_project_iam_member" "additive" {
  for_each = local.projects_bindings_additive

  member  = each.value.member
  project = each.value.project
  role    = each.value.role
}

/******************************************
  Project IAM binding authoritative
 *****************************************/
resource "google_project_iam_binding" "authoritative" {
  for_each = local.projects_bindings_authoritative

  members = each.value.members
  project = each.value.project
  role    = each.value.role
}

