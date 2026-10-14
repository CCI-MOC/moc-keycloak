"""Functional tests for the privacy and security notice shown on the login page
(loginTitleHtml in realm_moc.tf).
"""

import base64
import hashlib
import secrets

import requests

from conftest import KEYCLOAK_URL, REALM


def get_login_page():
    """Starts a login to the account console, returning the response."""
    verifier = secrets.token_urlsafe(32)
    challenge = (
        base64.urlsafe_b64encode(hashlib.sha256(verifier.encode()).digest())
        .rstrip(b"=")
        .decode()
    )
    return requests.get(
        f"{KEYCLOAK_URL}/realms/{REALM}/protocol/openid-connect/auth",
        params={
            "client_id": "account-console",
            "redirect_uri": f"{KEYCLOAK_URL}/realms/{REALM}/account/",
            "response_type": "code",
            "scope": "openid",
            "code_challenge": challenge,
            "code_challenge_method": "S256",
        },
        allow_redirects=False,
    )


def test_login_page_displays_notice():
    response = get_login_page()

    # The login page is shown rather than redirecting straight to CILogon,
    # so the notice is displayed before the user signs in.
    assert response.status_code == 200
    assert "Privacy and Security Notice" in response.text
    assert "information system, which is provided for authorized use only" in response.text
    assert 'id="social-cilogon"' in response.text
