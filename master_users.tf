resource "keycloak_user" "temp_admin" {
  attributes = {
    is_temporary_admin = "true"
  }
  email            = "knikolla@bu.edu"
  email_verified   = false
  enabled          = true
  first_name       = ""
  import           = false
  last_name        = ""
  realm_id         = "master"
  required_actions = []
  username         = "temp-admin"

  lifecycle { prevent_destroy = true }
}
