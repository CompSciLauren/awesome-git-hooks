#!/usr/bin/env bats

LOG="./tests/tests.log"

logTest() {
    # $1 indicates the test status [PASS, FAIL]
    date >> "$LOG"
    echo "delete-pyc-files test: $1" >> "$LOG"
    echo "" >> "$LOG"
    echo "--------------------------------------------" >> "$LOG"
    echo "" >> "$LOG"
}

setup() {
    # Create dummy .pyc files to test removal
    touch 1.pyc 2.pyc
}

teardown() {
    rm -f 1.pyc 2.pyc
}

@test "pyc files are purged upon branch checkout" {
    git checkout
    if [ -z "$(ls *.pyc)" ]; then
        logTest "PASS"
    else
        logTest "FAIL"
        [ "$output" = "pyc files were not deleted" ]
    fi
}
