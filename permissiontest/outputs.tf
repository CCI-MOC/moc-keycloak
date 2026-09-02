# Expose only the md5 hash of the secret value so we can confirm the value was
# retrieved without revealing the secret itself.
output "testsecret_md5" {
  description = "md5 hash of the cluster/moc-services/testsecret value"
  value       = md5(data.aws_secretsmanager_secret_version.testsecret.secret_string)
  sensitive   = true
}
