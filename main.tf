
locals {
  realm_id                = "moc"
  openshift_oidc_clusters = {
    oac_prod_infra = {
      cluster_name            = "oac-prod-infra"
      openshift_redirect_uri  = "https://oauth-openshift.apps.infra.oac.ocp.massopen.cloud/oauth2callback/mocsso"
      client_secret_name      = "cluster/oac-prod-infra/keycloak-oidc"
      keycloak_client_uuid    = "oac-prod-infra"
      secret_arn              = "arn:aws:secretsmanager:us-east-1:574733721584:secret:cluster/oac-prod-infra/keycloak-oidc-Y0zXED"
      secret_version_id       = "c3b5757f-b95e-458a-8325-30292a02c86b"
    }
    oac_prod_workload0 = {
      cluster_name            = "oac-prod-workload0"
      openshift_redirect_uri  = "https://oauth-oac-prod-workload0.hcp.oac.massopen.cloud:443/oauth2callback/mocsso"
      client_secret_name      = "cluster/oac-prod-infra/hostedcluster/oac-prod-workload0/keycloak-oidc"
      keycloak_client_uuid    = "oac-prod-workload0"
      secret_arn              = "arn:aws:secretsmanager:us-east-1:574733721584:secret:cluster/oac-prod-infra/hostedcluster/oac-prod-workload0/keycloak-oidc-QZ22Hu"
      secret_version_id       = "87e647cd-8470-44da-8ad1-d8655af1e1b0"
    }
  }
}

import {
  for_each = local.openshift_oidc_clusters
  to       = module.openshift_oidc[each.key].keycloak_openid_client.this
  id       = "${local.realm_id}/${each.value.keycloak_client_uuid}"
}

import {
  for_each = local.openshift_oidc_clusters
  to       = module.openshift_oidc[each.key].aws_secretsmanager_secret.this
  id       = each.value.client_secret_name # Or each.value.secret_arn
}

import {
  for_each = local.openshift_oidc_clusters
  to       = module.openshift_oidc[each.key].aws_secretsmanager_secret_version.this
  id       = "${each.value.secret_arn}|${each.value.secret_version_id}"
}

module "openshift_oidc" {
  for_each = local.openshift_oidc_clusters

  source                 = "./modules/openshift-oidc"
  cluster_name           = each.value.cluster_name
  openshift_redirect_uri = each.value.openshift_redirect_uri
  client_secret_name     = each.value.client_secret_name
}
