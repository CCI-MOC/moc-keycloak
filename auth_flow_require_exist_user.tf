resource "keycloak_authentication_flow" "require_existing_user_first_broker_login" {
  realm_id    = keycloak_realm.moc.id
  alias       = "Require Existing User First Broker Login"
  description = ""
  provider_id = "basic-flow"
}

resource "keycloak_authentication_execution" "detect_existing_broker_user" {
  realm_id          = keycloak_realm.moc.id
  parent_flow_alias = keycloak_authentication_flow.require_existing_user_first_broker_login.alias
  authenticator     = "idp-detect-existing-broker-user"
  requirement       = "REQUIRED"
  priority          = 0
}

resource "keycloak_authentication_execution" "auto_link_existing_user" {
  realm_id          = keycloak_realm.moc.id
  parent_flow_alias = keycloak_authentication_flow.require_existing_user_first_broker_login.alias
  authenticator     = "idp-auto-link"
  requirement       = "REQUIRED"
  priority          = 1
}
