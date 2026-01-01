#!/usr/bin/env bats

LOG="./tests/tests.log"
TEST_BRANCH="issue-9999999999/add-this-and-that"

logTest() {
    # $1 indicates the test status [PASS, FAIL]
    date >> "$LOG"
    echo "enforce insert issue number test: $1" >> "$LOG"
    echo "" >> "$LOG"
    echo "--------------------------------------------" >> "$LOG"
    echo "" >> "$LOG"
}

setup() {
    # Create a test branch that will be used to verify that the `commit-msg` hook works
    # 'issue-9999999999' is highly unlikely to exists and thus safer than having a normal issue number
    # which might collide with a real branch.
    git checkout -b "$TEST_BRANCH"
}

teardown() {
    # Go back to the previous branch
    git checkout -
    # Remove test branch
    git branch -D "$TEST_BRANCH"
}

@test "correct issue number format" {
    run $(git commit --allow-empty -m "$TEST_BRANCH")
    if [ "$status" -eq 0 ]; then
	logTest "PASS"
    else
	logTest "FAIL"
	[ "$output" = "incorrect commit message specified" ]
    fi
}

@test "wrong issue number format" {
    run git commit --allow-empty -m "NOT-CORRECT-ISSUE-FORMAT"
    if [ "$status" -eq 1 ]; then
	logTest "PASS"
    else
	logTest "FAIL"
	[ "$output" = "incorrect commit message specified" ]
    fi
}
