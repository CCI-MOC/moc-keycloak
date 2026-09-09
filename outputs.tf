output "openshift_oidc_secrets" {
  description = "The secret names and ARNs for OpenShift OIDC clients"
  sensitive   = true
  value = {
    for k, v in module.openshift_oidc : k => {
      secret_name = v.secret_name
      secret_arn  = v.secret_arn
    }
  }
}
