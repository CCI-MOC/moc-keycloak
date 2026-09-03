data "aws_secretsmanager_secret_version" "smtp_credentials" {
  count     = var.use_secrets_manager ? 1 : 0
  secret_id = "cluster/moc-services/keycloak/smtp"
}

data "aws_secretsmanager_secret_version" "cilogon_credentials" {
  count     = var.use_secrets_manager ? 1 : 0
  secret_id = "cluster/moc-services/keycloak/cilogon"
}

locals {
  smtp_credentials = var.use_secrets_manager ? jsondecode(data.aws_secretsmanager_secret_version.smtp_credentials[0].secret_string) : {
    username = "test"
    password = "test"
  }
  cilogon_credentials = var.use_secrets_manager ? jsondecode(data.aws_secretsmanager_secret_version.cilogon_credentials[0].secret_string) : {
    client_id     = "test"
    client_secret = "test"
  }
}
