output "secret_name" {
  description = "The name of the AWS Secrets Manager secret"
  value       = one(aws_secretsmanager_secret.this[*].name)
}

output "secret_arn" {
  description = "The ARN of the AWS Secrets Manager secret"
  value       = one(aws_secretsmanager_secret.this[*].arn)
}
