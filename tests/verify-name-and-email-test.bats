#!/usr/bin/env bats

LOG="./tests/tests.log"

teardown() {
    # Reset user.name to correct value
    if [[ "$(git config user.name)" != "Lauren Stephenson" ]]; then
        $(git config --unset-all user.name)
        $(git config user.name "Lauren Stephenson")
    fi

    # Reset user.email to correct value
    if [[ "$(git config user.email)" != "compscilauren@gmail.com" ]]; then
        $(git config --unset-all user.email)
        $(git config user.email "compscilauren@gmail.com")
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
