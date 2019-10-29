#!/usr/bin/env bats
# Test for pre_push_hooks/prevent_bad_push.hook

LOG="./tests/tests.log"

logTest() {
    # $1 indicates the test status [PASS, FAIL]
    date >> "$LOG"
    echo "prevent bad push test: $1" >> "$LOG"
    echo "" >> "$LOG"
    echo "--------------------------------------------" >> "$LOG"
    echo "" >> "$LOG"
}

@test "pre-push with wip commit" {
    # Create a dummy file
    FILE_NAME="test-$(date +%Y%M%d%H%m%S)"
    touch $FILE_NAME
    # Add it to git
    git add $FILE_NAME
    # Commit it
    git commit -m "WIP: added $FILE_NAME"
    # This command will be tested
    run git push
    # git push exits with status code 1
    # which is returned by the corresponding hook
    # check pre_push_hooks/prevent_bad_push.hook
    if [ $status -eq 1 ]; then
        logTest "PASS"
    else
        logTest "FAIL"
    fi
    # Reset the working tree. Move just a commit behind.
    git reset --hard HEAD~1
}
