locals {
  is_additive                     = var.mode == "additive"
  is_authoritative                = var.mode == "authoritative"
  is_folders_binding              = length(var.folders) > 0
  is_kms_crypto_keys_binding      = length(var.kms_crypto_keys) > 0
  is_kms_key_rings_binding        = length(var.kms_key_rings) > 0
  is_orgs_binding                 = length(var.organizations) > 0
  is_projects_binding             = length(var.projects) > 0
  is_pubsub_subscriptions_binding = length(var.pubsub_subscriptions) > 0
  is_pubsub_topics_binding        = length(var.pubsub_topics) > 0
  is_service_accounts_binding     = length(var.service_accounts) > 0
  is_storage_buckets_binding      = length(var.storage_buckets) > 0
  is_subnets_binding              = length(var.subnets) > 0
}

