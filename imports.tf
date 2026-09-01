
import {
  to = keycloak_realm.moc
  id = "moc"
}

# ------------------------------------------------------------------------------
# Auto-generated OpenTofu / Terraform Import Blocks
# Flow: CILogon First Broker Login
# Realm: moc
# ------------------------------------------------------------------------------

# Top-Level Parent Flow
import {
  to = keycloak_authentication_flow.cilogon_first_broker_login
  id = "moc/28975562-fd4b-4b74-a2bf-79bd5ae14a73"
}

# Execution: step
import {
  to = keycloak_authentication_execution.execution_0
  id = "moc/CILogon First Broker Login/4624947c-c5ac-416b-8224-1c093397db6e"
}

# Subflow: CILogon First Broker Login User creation or linking
import {
  to = keycloak_authentication_subflow.cilogon_first_broker_login_user_creation_or_linking_1
  id = "moc/CILogon First Broker Login/16e4ee7f-292c-45d7-bc3a-c5513c5d335e"
}

# Execution: step
import {
  to = keycloak_authentication_execution.execution_2
  id = "moc/CILogon First Broker Login/0857b9b9-02e4-4512-8c3b-d66eb850f111"
}

# Subflow: CILogon First Broker Login Handle Existing Account
import {
  to = keycloak_authentication_subflow.cilogon_first_broker_login_handle_existing_account_3
  id = "moc/CILogon First Broker Login/f5389bed-30fa-4559-95c5-364190471f03"
}

# Execution: step
import {
  to = keycloak_authentication_execution.execution_4
  id = "moc/CILogon First Broker Login/a6aa53ea-bb2e-494d-bebf-ca97eb1c65c7"
}

# Subflow: CILogon First Broker Login Account verification options
import {
  to = keycloak_authentication_subflow.cilogon_first_broker_login_account_verification_options_5
  id = "moc/CILogon First Broker Login/93ebd082-0b86-4c9f-8d89-69e8a10f7c3f"
}

# Execution: step
import {
  to = keycloak_authentication_execution.execution_6
  id = "moc/CILogon First Broker Login/2b4e9a70-a1f0-48e9-90f2-90d12fdcd840"
}

# Subflow: CILogon First Broker Login Verify Existing Account by Re-authentication
import {
  to = keycloak_authentication_subflow.cilogon_first_broker_login_verify_existing_account_by_re_authentication_7
  id = "moc/CILogon First Broker Login/da9d57f9-c125-4d07-a904-7d6814adf077"
}

# Execution: step
import {
  to = keycloak_authentication_execution.execution_8
  id = "moc/CILogon First Broker Login/e81de971-b987-450e-8bef-52f20664f63f"
}

# Subflow: CILogon First Broker Login First broker login - Conditional 2FA
import {
  to = keycloak_authentication_subflow.cilogon_first_broker_login_first_broker_login_conditional_2fa_9
  id = "moc/CILogon First Broker Login/d0695d6a-ebc3-46df-94cb-9c6d3b22c80b"
}

# Execution: step
import {
  to = keycloak_authentication_execution.execution_10
  id = "moc/CILogon First Broker Login/1285f645-a790-4c91-846e-506c65ec809e"
}

# Execution: step
import {
  to = keycloak_authentication_execution.execution_11
  id = "moc/CILogon First Broker Login/b3774177-2b55-447f-a832-f5378801a91a"
}

# Execution: step
import {
  to = keycloak_authentication_execution.execution_12
  id = "moc/CILogon First Broker Login/d267dd60-482c-4504-96ef-c808914fa477"
}

# Execution: step
import {
  to = keycloak_authentication_execution.execution_13
  id = "moc/CILogon First Broker Login/3cd6c780-75db-4f77-b550-79ea61b8e5a4"
}

# Execution: step
import {
  to = keycloak_authentication_execution.execution_14
  id = "moc/CILogon First Broker Login/0ae3713a-fa28-4fa0-99cb-682fb7b8f0e8"
}

# Subflow: CILogon First Broker Login First Broker Login - Conditional Organization
import {
  to = keycloak_authentication_subflow.cilogon_first_broker_login_first_broker_login_conditional_organization_15
  id = "moc/CILogon First Broker Login/b4406b3b-2986-4f2b-bce1-1ac3cccd4a1b"
}

# Execution: step
import {
  to = keycloak_authentication_execution.execution_16
  id = "moc/CILogon First Broker Login/6146bb6b-9216-4229-9426-915dc999eb57"
}

# Execution: step
import {
  to = keycloak_authentication_execution.execution_17
  id = "moc/CILogon First Broker Login/a7d84965-fd61-4aff-9be2-c9df35ef32dd"
}
