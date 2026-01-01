#!/usr/bin/env bats

LOG="./tests/tests.log"

setup() {
    # Preserve original user name/email
    ORIG_GIT_USER="$(git config --get --local user.name || true)"
    ORIG_GIT_EMAIL="$(git config --get --local user.email || true)"
}

teardown() {
    # Restore original user name/email
    git config --unset-all user.name
    git config --unset-all user.email

    if [ -n "$ORIG_GIT_USER"  ]; then
        git config --local user.name "$ORIG_GIT_USER"
    fi
    if [ -n "$ORIG_GIT_EMAIL" ]; then
        git config --local user.email "$ORIG_GIT_EMAIL"
    fi

    # Don't leave behind an empty [user] section
    if [ -z "$(git config --local -l | grep ^user)" ]; then
        git config --local --remove-section user 2>/dev/null || true
    fi
}

# Verifies that an error is thrown when a commit is attempted and the user.name is incorrect in the git config.
@test "incorrect name throws error" {
    testName="First Last"
    $(git config user.name $testName)

    { # try
        runGitCommit="$(git commit -m 'Failed commit')"
    } || { # catch
        date >> "$LOG"
        echo "incorrect name throws error test: PASS" >> "$LOG"
        echo "" >> "$LOG"
        echo "--------------------------------------------" >> "$LOG"
        echo "" >> "$LOG"
    }
}

# Verifies that an error is thrown when a commit is attempted and the user.email is incorrect in the git config.
@test "incorrect email throws error" {
    testEmail="first.last@gmail.com"
    $(git config user.email $testEmail)

    { # try
        runGitCommit="$(git commit -m 'Failed commit')"
    } || { # catch
        date >> "$LOG"
        echo "incorrect email throws error test: PASS" >> "$LOG"
        echo "" >> "$LOG"
        echo "--------------------------------------------" >> "$LOG"
        echo "" >> "$LOG"
    }
}
