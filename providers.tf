
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

provider "keycloak" {
  url       = var.KEYCLOAK_URL
  client_id = var.KEYCLOAK_CLIENT_ID
  username  = var.KEYCLOAK_USER_NAME
  password  = var.KEYCLOAK_PASSWORD
}

provider "aws" {
  region = "us-east-1"
}
