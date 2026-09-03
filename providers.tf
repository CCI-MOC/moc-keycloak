
variable "KEYCLOAK_URL" {
  type    = string
  default = "https://sso.massopen.cloud"
}

variable "KEYCLOAK_CLIENT_ID" {
  type    = string
  default = null
}

variable "KEYCLOAK_USER_NAME" {
  type    = string
  default = null
}

variable "KEYCLOAK_PASSWORD" {
  type      = string
  sensitive = true
  default   = null
}

variable "KEYCLOAK_JWT_TOKEN_FILE" {
  type        = string
  default     = null
  description = "Path to a file containing a signed JWT used for federated client authentication (used by CI instead of username/password)."
}

provider "keycloak" {
  url            = var.KEYCLOAK_URL
  client_id      = var.KEYCLOAK_CLIENT_ID
  username       = var.KEYCLOAK_USER_NAME
  password       = var.KEYCLOAK_PASSWORD
  jwt_token_file = var.KEYCLOAK_JWT_TOKEN_FILE
}

provider "aws" {
  region = "us-east-1"

  # When use_secrets_manager=false (local testing) no AWS resources or data sources
  # are in the graph, but the provider is still configured. Supply dummy static
  # credentials and skip the network validation/metadata calls so it can
  # configure without real AWS credentials. These have no effect when
  # use_secrets_manager=true, where real credentials are used.
  access_key                  = var.use_secrets_manager ? null : "test"
  secret_key                  = var.use_secrets_manager ? null : "test"
  skip_credentials_validation = !var.use_secrets_manager
  skip_requesting_account_id  = !var.use_secrets_manager
  skip_metadata_api_check     = !var.use_secrets_manager
}
