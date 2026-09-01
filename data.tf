data "aws_secretsmanager_secret_version" "smtp_credentials" {
  secret_id = "cluster/moc-services/keycloak/smtp"
}

locals {
  smtp_credentials = jsondecode(data.aws_secretsmanager_secret_version.smtp_credentials.secret_string)
}
