"""Smoke tests for the functional testing environment itself."""


def test_realm_is_bootstrapped(keycloak):
    realm = keycloak.request("GET", "").json()
    assert realm["realm"] == keycloak.realm


def test_realm_sends_email_to_mailpit(keycloak):
    smtp = keycloak.request("GET", "").json()["smtpServer"]
    assert smtp["host"] == "mailpit", "make init-local did not point SMTP at mailpit"


def test_users_can_log_in(keycloak, make_user):
    user = make_user("login", cilogon=False)
    assert keycloak.login(user)
