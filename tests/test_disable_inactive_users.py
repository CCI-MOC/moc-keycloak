"""Functional tests for the disable-inactive-users workflow
(workflow_disable_inactive_users.tf).

The workflow is applied with a 10s warning delay, a 10s disable delay and a 3s
scan interval (see WORKFLOW_VARS).
"""

import subprocess
import threading
import time
from contextlib import contextmanager

import pytest

from conftest import REPO_ROOT

# Shrinks the delays of the disable-inactive-users workflow to seconds.
WORKFLOW_VARS = [
    "-var", "inactive_user_warning_after=10s",
    "-var", "inactive_user_disable_after=10s",
    "-var", "inactive_user_scan_interval=3s",
]
DISABLED_GROUP = "/disabled-due-to-inactivity"

# Upper bound for the workflow to warn or disable a user once they are due:
# delay (10s) + scan interval (3s) + step runner interval (2s), with margin.
TIMEOUT = 60
# Longer than the warning and disable delays combined.
RESET_PERIOD = 30


def run_tofu(*args, check=True):
    """Runs tofu against the workflow only, with the short delays."""
    return subprocess.run(
        ["tofu", *args, "-target", "keycloak_workflow.disable_inactive_users", *WORKFLOW_VARS],
        cwd=REPO_ROOT,
        check=check,
    )


@pytest.fixture(scope="module")
def tofu():
    return run_tofu


@pytest.fixture(scope="module", autouse=True)
def workflow():
    """Applies the disable-inactive-users workflow with short delays."""
    run_tofu("apply", "-auto-approve")


def is_disabled_by_workflow(keycloak, user_id):
    """Whether the user is disabled and marked by the workflow."""
    groups = keycloak.get(f"/users/{user_id}/groups")
    return not keycloak.is_enabled(user_id) and any(
        group["path"] == DISABLED_GROUP for group in groups
    )


def wait_until(condition, description, check=None):
    """Polls until condition() is true, calling check() on every poll."""
    deadline = time.monotonic() + TIMEOUT
    while True:
        if check:
            check()
        if condition():
            return
        if time.monotonic() > deadline:
            pytest.fail(f"timed out after {TIMEOUT}s waiting until {description}")
        time.sleep(1)


def holds_for(seconds, check):
    """Calls check() every second for the given number of seconds."""
    deadline = time.monotonic() + seconds
    while time.monotonic() < deadline:
        check()
        time.sleep(1)


@contextmanager
def keep_logging_in(keycloak, user, interval=3):
    """Logs in as the user every few seconds, well within the warning delay."""
    assert keycloak.login(user), "user cannot log in"
    stop = threading.Event()

    def loop():
        while not stop.wait(interval):
            keycloak.login(user)

    thread = threading.Thread(target=loop, daemon=True)
    thread.start()
    try:
        yield
    finally:
        stop.set()
        thread.join()


def test_workflow_has_no_drift(workflow, tofu):
    result = tofu("plan", "-detailed-exitcode", check=False)
    assert result.returncode == 0, "tofu plan reports changes right after apply"


def test_inactive_user_is_warned_then_disabled(keycloak, mailpit, make_user):
    user = make_user("inactive", cilogon=True)

    wait_until(lambda: mailpit.count(user.email) >= 1, "the user is warned")
    assert keycloak.is_enabled(user.id), "user was disabled before the disable delay elapsed"

    wait_until(lambda: is_disabled_by_workflow(keycloak, user.id), "the user is disabled")

    # Over several scans, the disabled user must not be re-enrolled.
    def check():
        assert mailpit.count(user.email) == 1, "disabled user was notified again"
        assert not keycloak.is_enabled(user.id), "disabled user was re-enabled"

    holds_for(20, check)


def test_login_resets_countdown(keycloak, mailpit, make_user):
    user = make_user("active", cilogon=True)

    def check():
        assert keycloak.is_enabled(user.id), "user who keeps logging in was disabled"
        assert mailpit.count(user.email) == 0, "user who keeps logging in was warned"

    with keep_logging_in(keycloak, user):
        holds_for(RESET_PERIOD, check)

    wait_until(lambda: mailpit.count(user.email) >= 1, "the user is warned after they stop logging in")
    wait_until(lambda: is_disabled_by_workflow(keycloak, user.id), "the user is disabled")


def test_users_outside_policy_are_ignored(keycloak, mailpit, make_user, service_account_user_id):
    local_user = make_user("local", cilogon=False)
    # Once this user is disabled, the others have had as long to be.
    canary = make_user("canary", cilogon=True)

    def check():
        assert keycloak.is_enabled(local_user.id), "user without a CILogon link was disabled"
        assert keycloak.is_enabled(service_account_user_id), "service account user was disabled"

    wait_until(lambda: is_disabled_by_workflow(keycloak, canary.id), "the canary user is disabled", check=check)
    assert mailpit.count(local_user.email) == 0, "user without a CILogon link was warned"
