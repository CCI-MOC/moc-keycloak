"""Fixtures for the functional tests.

The tests run against the local Keycloak and mailpit from compose.yaml, after
`make bootstrap`.
"""

import os
import time
import uuid
from dataclasses import dataclass
from pathlib import Path

import pytest
import requests

KEYCLOAK_URL = os.environ.get("KEYCLOAK_URL", "http://localhost:8080")
MAILPIT_URL = os.environ.get("MAILPIT_URL", "http://localhost:8025")
REALM = "moc"
REPO_ROOT = Path(__file__).resolve().parent.parent

PASSWORD = "functest-password"


@dataclass
class User:
    id: str
    username: str
    email: str


class Keycloak:
    """Client for the admin REST API of the test realm."""

    def __init__(self, url, realm):
        self.url = url
        self.realm = realm
        self._token = None
        self._token_expires = 0.0

    def _admin_token(self):
        # Master realm admin tokens expire after 60s; renew them ahead of time.
        if time.monotonic() > self._token_expires - 10:
            response = requests.post(
                f"{self.url}/realms/master/protocol/openid-connect/token",
                data={
                    "client_id": "admin-cli",
                    "grant_type": "password",
                    "username": "admin",
                    "password": "admin",
                },
            )
            response.raise_for_status()
            body = response.json()
            self._token = body["access_token"]
            self._token_expires = time.monotonic() + body["expires_in"]
        return self._token

    def request(self, method, path, **kwargs):
        response = requests.request(
            method,
            f"{self.url}/admin/realms/{self.realm}{path}",
            headers={"Authorization": f"Bearer {self._admin_token()}"},
            **kwargs,
        )
        response.raise_for_status()
        return response

    def get(self, path, **kwargs):
        return self.request("GET", path, **kwargs).json()

    def create(self, path, json):
        """Creates a resource and returns its id."""
        response = self.request("POST", path, json=json)
        return response.headers["Location"].rsplit("/", 1)[-1]

    def delete(self, path):
        self.request("DELETE", path)

    def login(self, user):
        """Logs in as the user with their password, returning whether it succeeded."""
        response = requests.post(
            f"{self.url}/realms/{self.realm}/protocol/openid-connect/token",
            data={
                "client_id": "admin-cli",
                "grant_type": "password",
                "scope": "openid",
                "username": user.username,
                "password": PASSWORD,
            },
        )
        return response.ok

    def is_enabled(self, user_id):
        return self.get(f"/users/{user_id}")["enabled"]


class Mailpit:
    """Client for the API of the mailpit instance capturing Keycloak's email."""

    def __init__(self, url):
        self.url = url

    def count(self, email):
        """Returns the number of messages sent to the address."""
        response = requests.get(
            f"{self.url}/api/v1/search", params={"query": f"to:{email}"}
        )
        response.raise_for_status()
        return len(response.json()["messages"])


@pytest.fixture(scope="session")
def keycloak():
    return Keycloak(KEYCLOAK_URL, REALM)


@pytest.fixture(scope="session")
def mailpit():
    return Mailpit(MAILPIT_URL)


@pytest.fixture
def make_user(keycloak):
    """Creates users with a password, deleting them after the test.

    Usernames and emails are unique per call, so tests don't see each other's
    users or messages.
    """
    created = []

    def make(name, cilogon):
        username = f"functest-{name}-{uuid.uuid4().hex[:8]}"
        email = f"{username}@example.com"
        user_id = keycloak.create(
            "/users",
            {
                "username": username,
                "email": email,
                "emailVerified": True,
                "enabled": True,
                "firstName": "Functional",
                "lastName": "Test",
                "credentials": [
                    {"type": "password", "value": PASSWORD, "temporary": False}
                ],
            },
        )
        created.append(user_id)
        # The realm has registration_email_as_username, so Keycloak replaces
        # the username with the email.
        username = keycloak.get(f"/users/{user_id}")["username"]
        if cilogon:
            keycloak.request(
                "POST",
                f"/users/{user_id}/federated-identity/cilogon",
                json={
                    "identityProvider": "cilogon",
                    "userId": user_id,
                    "userName": username,
                },
            )
        return User(user_id, username, email)

    yield make

    for user_id in created:
        keycloak.delete(f"/users/{user_id}")


@pytest.fixture
def service_account_user_id(keycloak):
    """Creates a client with a service account and returns the account's user id."""
    client_id = keycloak.create(
        "/clients",
        {
            "clientId": f"functest-sa-{uuid.uuid4().hex[:8]}",
            "publicClient": False,
            "serviceAccountsEnabled": True,
            "standardFlowEnabled": False,
            "directAccessGrantsEnabled": False,
        },
    )
    yield keycloak.get(f"/clients/{client_id}/service-account-user")["id"]
    keycloak.delete(f"/clients/{client_id}")
