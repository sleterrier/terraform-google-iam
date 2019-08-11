/******************************************
  Locals configuration for module logic
 *****************************************/
locals {
  kms_crypto_keys_bindings_additive_pairs = flatten([
    for kms_crypto_key in var.kms_crypto_keys: [
      for role, members in var.bindings: [
        for member in members: {
          kms_crypto_key = kms_crypto_key
          member         = member
          role           = role
        }
      ]
    ]
    if local.is_kms_crypto_keys_binding && local.is_additive
  ])

  kms_crypto_keys_bindings_additive = {
    for pair in local.kms_crypto_keys_bindings_additive_pairs:
      "${pair.kms_crypto_key}__${pair.role}__${pair.member}" => pair
  }

  kms_crypto_keys_bindings_authoritative_pairs = flatten([
    for kms_crypto_key in var.kms_crypto_keys: [
      for role, members in var.bindings: {
          kms_crypto_key = kms_crypto_key
          members        = members
          role           = role
      }
    ]
    if local.is_kms_crypto_keys_binding && local.is_authoritative
  ])

  kms_crypto_keys_bindings_authoritative = {
    for pair in local.kms_crypto_keys_bindings_authoritative_pairs:
      "${pair.kms_crypto_key}__${pair.role}" => pair
  }
}

#/******************************************
#  Kms Crypto Key IAM binding additive
# *****************************************/
resource "google_kms_crypto_key_iam_member" "additive" {
  for_each = local.kms_crypto_keys_bindings_additive

  crypto_key_id = each.value.kms_crypto_key
  member        = each.value.member
  role          = each.value.role
}

/******************************************
  Kms Crypto Key IAM binding authoritative
 *****************************************/
resource "google_kms_crypto_key_iam_binding" "authoritative" {
  for_each = local.kms_crypto_keys_bindings_authoritative

  crypto_key_id = each.value.kms_crypto_key
  members       = each.value.members
  role          = each.value.role
}

