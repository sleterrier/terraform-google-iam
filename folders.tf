/******************************************
  Locals configuration for module logic
 *****************************************/
locals {
  folders_bindings_additive_pairs = flatten([
    for folder in var.folders: [
      for role, members in var.bindings: [
        for member in members: {
          folder = folder
          member = member
          role = role
        }
      ]
    ]
    if local.is_folders_binding && local.is_additive
  ])

  folders_bindings_additive = {
    for pair in local.folders_bindings_additive_pairs:
      "${pair.folder}__${pair.role}__${pair.member}" => pair
  }

  folders_bindings_authoritative_pairs = flatten([
    for folder in var.folders: [
      for role, members in var.bindings: {
          folder  = folder
          members = members
          role    = role
      }
    ]
    if local.is_folders_binding && local.is_authoritative
  ])

  folders_bindings_authoritative = {
    for pair in local.folders_bindings_authoritative_pairs:
      "${pair.folder}__${pair.role}" => pair
  }
}

/******************************************
  Folder IAM binding additive
 *****************************************/
resource "google_folder_iam_member" "additive" {
  for_each = local.folders_bindings_additive

  folder = each.value.folder
  member = each.value.member
  role   = each.value.role
}

/******************************************
  Folder IAM binding authoritative
 *****************************************/
resource "google_folder_iam_binding" "authoritative" {
  for_each = local.folders_bindings_authoritative

  folder  = each.value.folder
  members = each.value.members
  role    = each.value.role
}

