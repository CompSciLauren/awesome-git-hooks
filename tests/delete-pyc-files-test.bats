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
    # install/enable hook
    if [ -e .git/hooks/post-checkout ]; then
        mv -f .git/hooks/post-checkout .git/hooks/post-checkout.bak-delete-pyc-files
    fi

    cp -f post-checkout-hooks/delete-pyc-files.hook .git/hooks/post-checkout
    chmod 0755 .git/hooks/post-checkout

    # Create dummy .pyc files to test removal
    touch 1.pyc 2.pyc
}

teardown() {
    # remove/disable hook
    rm -f .git/hooks/post-checkout

    # restore previous hook, if any
    if [ -e .git/hooks/post-checkout.bak-delete-pyc-files ]; then
        mv -f .git/hooks/post-checkout.bak-delete-pyc-files .git/hooks/post-checkout
    fi

    # clean up test files
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
