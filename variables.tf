variable "first_broker_login_flow" {
  type        = string
  description = "Name of first broker login authentication flow"
  default     = "CILogon First Broker Login"
}

variable "store_secrets" {
  type        = bool
  default     = true
  description = "Store secrets to AWS secrets manager when true"
}
