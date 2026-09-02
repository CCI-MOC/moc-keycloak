# Fetch the test secret used to verify that the GitHub Actions OIDC role has
# read access to AWS Secrets Manager.
data "aws_secretsmanager_secret_version" "testsecret" {
  secret_id = "cluster/moc-services/testsecret"
}
