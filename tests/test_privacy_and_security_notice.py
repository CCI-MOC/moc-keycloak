"""Functional tests for the privacy and security notice shown on the login page
(loginTitleHtml in realm_moc.tf).
"""

import base64
import hashlib
import secrets

import requests
from playwright.sync_api import Page

from conftest import KEYCLOAK_URL, REALM, REPO_ROOT

# Uploaded as an artifact by the bootstrap workflow.
SCREENSHOT_DIR = REPO_ROOT / "screenshots"


def login_url():
    """Returns the URL that starts a login to the account console."""
    verifier = secrets.token_urlsafe(32)
    challenge = (
        base64.urlsafe_b64encode(hashlib.sha256(verifier.encode()).digest())
        .rstrip(b"=")
        .decode()
    )
    return requests.Request(
        "GET",
        f"{KEYCLOAK_URL}/realms/{REALM}/protocol/openid-connect/auth",
        params={
            "client_id": "account-console",
            "redirect_uri": f"{KEYCLOAK_URL}/realms/{REALM}/account/",
            "response_type": "code",
            "scope": "openid",
            "code_challenge": challenge,
            "code_challenge_method": "S256",
        },
    ).prepare().url


def test_login_page_displays_notice():
    response = requests.get(login_url(), allow_redirects=False)

    # The login page is shown rather than redirecting straight to CILogon,
    # so the notice is displayed before the user signs in.
    assert response.status_code == 200
    assert "Privacy and Security Notice" in response.text
    assert "information system, which is provided for authorized use only" in response.text
    assert 'id="social-cilogon"' in response.text


def test_login_page_screenshot(page: Page):
    page.goto(login_url())
    page.locator("#social-cilogon").wait_for()
    page.screenshot(path=SCREENSHOT_DIR / "login_page.png", full_page=True)
