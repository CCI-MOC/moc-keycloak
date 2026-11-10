# Users disabled by the workflow below are added to this group, and members are
# excluded from the workflow so they are not re-enrolled and notified again.
# Remove a user from it when re-enabling them to put them back under the policy.
#
# A group rather than a user attribute, since attributes not declared in the
# user profile are hidden from the admin console and API by default.
resource "keycloak_group" "disabled_due_to_inactivity" {
  realm_id = keycloak_realm.moc.id
  name     = "disabled-due-to-inactivity"
}

# Disables users who have not logged in for 45 days (inactive_user_warning_after
# + inactive_user_disable_after), per NIST AC-2(3).
#
# Keycloak has no "last login" condition. Instead, every eligible user is bound
# to a workflow execution whose steps are delayed; each login restarts the
# execution from the first step, resetting the inactivity countdown.
#
# - on: user_authenticated enrolls a user (or restarts their execution) on login.
# - schedule: enrolls existing users that have no execution yet, daily, in
#   batches. Their countdown starts at enrollment.
# - conditions: only users linked to CILogon. This excludes service account
#   users (which the scheduled scan would otherwise pick up). Users already
#   disabled by this workflow are excluded too.
resource "keycloak_workflow" "disable_inactive_users" {
  realm               = keycloak_realm.moc.id
  name                = "disable-inactive-users"
  on                  = "user_authenticated"
  enabled             = true
  restart_in_progress = "true"
  conditions          = "has-identity-provider-link(${keycloak_oidc_identity_provider.cilogon.alias}) and not is-member-of(${keycloak_group.disabled_due_to_inactivity.path})"

  schedule {
    after      = var.inactive_user_scan_interval
    batch_size = 100
  }

  # With no message configured, notify-user sends Keycloak's built-in
  # "account will be disabled in N days due to inactivity" email.
  step {
    uses  = "notify-user"
    after = var.inactive_user_warning_after
  }

  step {
    uses  = "disable-user"
    after = var.inactive_user_disable_after
  }

  step {
    uses = "join-group"
    config = {
      group = keycloak_group.disabled_due_to_inactivity.path
    }
  }
}
