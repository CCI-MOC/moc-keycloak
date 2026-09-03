import {
  to = keycloak_realm.moc
  id = "moc"
}

import {
  to = keycloak_oidc_identity_provider.cilogon
  id = "moc/cilogon"
}

import {
  for_each = local.openshift_oidc_clusters
  to       = module.openshift_oidc[each.key].keycloak_openid_client.this
  id       = "${local.realm_id}/${each.value.keycloak_client_uuid}"
}

import {
  for_each = local.openshift_oidc_clusters
  to       = module.openshift_oidc[each.key].aws_secretsmanager_secret.this[0]
  id       = each.value.client_secret_name # Or each.value.secret_arn
}

import {
  for_each = local.openshift_oidc_clusters
  to       = module.openshift_oidc[each.key].aws_secretsmanager_secret_version.this[0]
  id       = "${each.value.secret_arn}|${each.value.secret_version_id}"
}
