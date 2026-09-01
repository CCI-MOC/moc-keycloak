# __generated__ by OpenTofu
# Please review these resources and move them into your main configuration files.

# __generated__ by OpenTofu from "moc/CILogon First Broker Login/6146bb6b-9216-4229-9426-915dc999eb57"
resource "keycloak_authentication_execution" "execution_16" {
  authenticator     = "conditional-user-configured"
  parent_flow_alias = "CILogon First Broker Login"
  priority          = 10
  realm_id          = "moc"
  requirement       = "REQUIRED"
}

# __generated__ by OpenTofu from "moc/CILogon First Broker Login/a6aa53ea-bb2e-494d-bebf-ca97eb1c65c7"
resource "keycloak_authentication_execution" "execution_4" {
  authenticator     = "idp-confirm-link"
  parent_flow_alias = "CILogon First Broker Login"
  priority          = 10
  realm_id          = "moc"
  requirement       = "DISABLED"
}

# __generated__ by OpenTofu from "moc/CILogon First Broker Login/4624947c-c5ac-416b-8224-1c093397db6e"
resource "keycloak_authentication_execution" "execution_0" {
  authenticator     = "idp-review-profile"
  parent_flow_alias = "CILogon First Broker Login"
  priority          = 10
  realm_id          = "moc"
  requirement       = "DISABLED"
}

# __generated__ by OpenTofu from "moc/CILogon First Broker Login/0857b9b9-02e4-4512-8c3b-d66eb850f111"
resource "keycloak_authentication_execution" "execution_2" {
  authenticator     = "idp-create-user-if-unique"
  parent_flow_alias = "CILogon First Broker Login"
  priority          = 10
  realm_id          = "moc"
  requirement       = "ALTERNATIVE"
}

# __generated__ by OpenTofu from "moc/CILogon First Broker Login/2b4e9a70-a1f0-48e9-90f2-90d12fdcd840"
resource "keycloak_authentication_execution" "execution_6" {
  authenticator     = "idp-email-verification"
  parent_flow_alias = "CILogon First Broker Login"
  priority          = 10
  realm_id          = "moc"
  requirement       = "REQUIRED"
}

# __generated__ by OpenTofu from "moc/CILogon First Broker Login/b3774177-2b55-447f-a832-f5378801a91a"
resource "keycloak_authentication_execution" "execution_11" {
  authenticator     = "conditional-credential"
  parent_flow_alias = "CILogon First Broker Login"
  priority          = 20
  realm_id          = "moc"
  requirement       = "REQUIRED"
}

# __generated__ by OpenTofu from "moc/CILogon First Broker Login/d267dd60-482c-4504-96ef-c808914fa477"
resource "keycloak_authentication_execution" "execution_12" {
  authenticator     = "auth-otp-form"
  parent_flow_alias = "CILogon First Broker Login"
  priority          = 30
  realm_id          = "moc"
  requirement       = "DISABLED"
}

# __generated__ by OpenTofu from "moc/CILogon First Broker Login/3cd6c780-75db-4f77-b550-79ea61b8e5a4"
resource "keycloak_authentication_execution" "execution_13" {
  authenticator     = "webauthn-authenticator"
  parent_flow_alias = "CILogon First Broker Login"
  priority          = 40
  realm_id          = "moc"
  requirement       = "DISABLED"
}

# __generated__ by OpenTofu from "moc/CILogon First Broker Login/0ae3713a-fa28-4fa0-99cb-682fb7b8f0e8"
resource "keycloak_authentication_execution" "execution_14" {
  authenticator     = "auth-recovery-authn-code-form"
  parent_flow_alias = "CILogon First Broker Login"
  priority          = 50
  realm_id          = "moc"
  requirement       = "DISABLED"
}

# __generated__ by OpenTofu from "moc/CILogon First Broker Login/1285f645-a790-4c91-846e-506c65ec809e"
resource "keycloak_authentication_execution" "execution_10" {
  authenticator     = "conditional-user-configured"
  parent_flow_alias = "CILogon First Broker Login"
  priority          = 10
  realm_id          = "moc"
  requirement       = "REQUIRED"
}

# __generated__ by OpenTofu from "moc/CILogon First Broker Login/e81de971-b987-450e-8bef-52f20664f63f"
resource "keycloak_authentication_execution" "execution_8" {
  authenticator     = "idp-username-password-form"
  parent_flow_alias = "CILogon First Broker Login"
  priority          = 10
  realm_id          = "moc"
  requirement       = "REQUIRED"
}

# __generated__ by OpenTofu from "moc/CILogon First Broker Login/16e4ee7f-292c-45d7-bc3a-c5513c5d335e"
resource "keycloak_authentication_subflow" "cilogon_first_broker_login_user_creation_or_linking_1" {
  alias             = "CILogon First Broker Login User creation or linking"
  authenticator     = ""
  description       = "Flow for the existing/non-existing user alternatives"
  parent_flow_alias = "CILogon First Broker Login"
  priority          = 20
  provider_id       = "basic-flow"
  realm_id          = "moc"
  requirement       = "REQUIRED"
}

# __generated__ by OpenTofu from "moc/CILogon First Broker Login/d0695d6a-ebc3-46df-94cb-9c6d3b22c80b"
resource "keycloak_authentication_subflow" "cilogon_first_broker_login_first_broker_login_conditional_2fa_9" {
  alias             = "CILogon First Broker Login First broker login - Conditional 2FA"
  authenticator     = ""
  description       = "Flow to determine if any 2FA is required for the authentication"
  parent_flow_alias = "CILogon First Broker Login"
  priority          = 20
  provider_id       = "basic-flow"
  realm_id          = "moc"
  requirement       = "CONDITIONAL"
}

# __generated__ by OpenTofu from "moc/CILogon First Broker Login/a7d84965-fd61-4aff-9be2-c9df35ef32dd"
resource "keycloak_authentication_execution" "execution_17" {
  authenticator     = "idp-add-organization-member"
  parent_flow_alias = "CILogon First Broker Login"
  priority          = 20
  realm_id          = "moc"
  requirement       = "REQUIRED"
}

# __generated__ by OpenTofu from "moc/CILogon First Broker Login/93ebd082-0b86-4c9f-8d89-69e8a10f7c3f"
resource "keycloak_authentication_subflow" "cilogon_first_broker_login_account_verification_options_5" {
  alias             = "CILogon First Broker Login Account verification options"
  authenticator     = ""
  description       = "Method with which to verify the existing account"
  parent_flow_alias = "CILogon First Broker Login"
  priority          = 20
  provider_id       = "basic-flow"
  realm_id          = "moc"
  requirement       = "REQUIRED"
}

# __generated__ by OpenTofu from "moc/28975562-fd4b-4b74-a2bf-79bd5ae14a73"
resource "keycloak_authentication_flow" "cilogon_first_broker_login" {
  alias       = "CILogon First Broker Login"
  description = "Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account"
  provider_id = "basic-flow"
  realm_id    = "moc"
}

# __generated__ by OpenTofu from "moc/CILogon First Broker Login/f5389bed-30fa-4559-95c5-364190471f03"
resource "keycloak_authentication_subflow" "cilogon_first_broker_login_handle_existing_account_3" {
  alias             = "CILogon First Broker Login Handle Existing Account"
  authenticator     = ""
  description       = "Handle what to do if there is existing account with same email/username like authenticated identity provider"
  parent_flow_alias = "CILogon First Broker Login"
  priority          = 20
  provider_id       = "basic-flow"
  realm_id          = "moc"
  requirement       = "ALTERNATIVE"
}

# __generated__ by OpenTofu from "moc/CILogon First Broker Login/da9d57f9-c125-4d07-a904-7d6814adf077"
resource "keycloak_authentication_subflow" "cilogon_first_broker_login_verify_existing_account_by_re_authentication_7" {
  alias             = "CILogon First Broker Login Verify Existing Account by Re-authentication"
  authenticator     = ""
  description       = "Reauthentication of existing account"
  parent_flow_alias = "CILogon First Broker Login"
  priority          = 20
  provider_id       = "basic-flow"
  realm_id          = "moc"
  requirement       = "DISABLED"
}

# __generated__ by OpenTofu from "moc/CILogon First Broker Login/b4406b3b-2986-4f2b-bce1-1ac3cccd4a1b"
resource "keycloak_authentication_subflow" "cilogon_first_broker_login_first_broker_login_conditional_organization_15" {
  alias             = "CILogon First Broker Login First Broker Login - Conditional Organization"
  authenticator     = ""
  description       = "Flow to determine if the authenticator that adds organization members is to be used"
  parent_flow_alias = "CILogon First Broker Login"
  priority          = 60
  provider_id       = "basic-flow"
  realm_id          = "moc"
  requirement       = "CONDITIONAL"
}
