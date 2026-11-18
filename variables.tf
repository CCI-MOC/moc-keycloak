variable "first_broker_login_flow" {
  type        = string
  description = "Name of first broker login authentication flow"
  default     = "Require Existing User First Broker Login"
}

variable "use_secrets_manager" {
  type        = bool
  default     = true
  description = "Read secrets from and store secrets to AWS Secrets Manager when true. Set to false for local testing without AWS credentials."
}

variable "github_actions_issuer" {
  type        = string
  description = "OIDC issuer for GitHub Actions tokens."
  default     = "https://token.actions.githubusercontent.com"
}

variable "github_actions_jwks_url" {
  type        = string
  description = "JWKS URL used to verify GitHub Actions OIDC token signatures."
  default     = "https://token.actions.githubusercontent.com/.well-known/jwks"
}

variable "github_actions_subject" {
  type        = string
  description = "GitHub Actions OIDC `sub` claim allowed to authenticate as the federated apply client (push to main)."
  # This repo's OIDC subject uses GitHub's immutable org/repo IDs, so the plain
  # "repo:CCI-MOC/moc-keycloak:..." form is never what the token carries and
  # would never match. Value obtained with:
  #   gh api repos/CCI-MOC/moc-keycloak/actions/oidc/customization/sub --jq .sub_claim_prefix
  default = "repo:CCI-MOC@3578683/moc-keycloak@1352835750:ref:refs/heads/main"
}

variable "github_actions_plan_subject" {
  type        = string
  description = "GitHub Actions OIDC `sub` claim allowed to authenticate as the federated plan client (pull_request events)."
  # pull_request events carry a different sub suffix than branch-push events.
  default = "repo:CCI-MOC@3578683/moc-keycloak@1352835750:pull_request"
}

variable "inactive_user_warning_after" {
  type        = string
  description = "Time since a user's last login after which they are warned that their account will be disabled for inactivity."
  default     = "38d"
}

variable "inactive_user_disable_after" {
  type        = string
  description = "Time after the inactivity warning after which the user is disabled."
  default     = "7d"
}

variable "inactive_user_scan_interval" {
  type        = string
  description = "Interval at which existing users without an inactivity workflow execution are enrolled."
  default     = "1d"
}

variable "smtp_host" {
  type    = string
  default = "email-smtp.us-east-1.amazonaws.com"
}

variable "smtp_port" {
  type    = string
  default = "465"
}

variable "smtp_ssl" {
  type    = bool
  default = true
}
