variable "cluster_name" {
  type = string
  description = "The name of the OpenShift cluster"
}

variable "openshift_redirect_uri" {
  type = string
  description = "The OAuth2 callback URL of the OpenShift Cluster for the Keycloak identity provider"
}

variable "client_secret_name" {
  type = string
  description = "The Keycloak client_id and client_secret for the OpenShift cluster"
}
