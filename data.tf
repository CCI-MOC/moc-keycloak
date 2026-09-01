data "aws_secretsmanager_secret_version" "smtp_credentials" {
  secret_id = "cluster/moc-services/keycloak/smtp"
}

data "aws_secretsmanager_secret_version" "cilogon_credentials" {
  secret_id = "cluster/moc-services/keycloak/cilogon"
}

locals {
  smtp_credentials    = jsondecode(data.aws_secretsmanager_secret_version.smtp_credentials.secret_string)
  cilogon_credentials = jsondecode(data.aws_secretsmanager_secret_version.cilogon_credentials.secret_string)
}
