#!/usr/bin/env bats

LOG="./tests/tests.log"

logTest() {
    # $1 indicates the test status [PASS, FAIL]
    date >> "$LOG"
    echo "search-term test: $1" >> "$LOG"
    echo "" >> "$LOG"
    echo "--------------------------------------------" >> "$LOG"
    echo "" >> "$LOG"
}

setup() {
    # create branch for our test content
    git checkout -b search-term-test-throwaway origin/master
}

teardown() {
    # unstage, remove test file
    git reset
    rm -f search-term-test-throwaway.txt

    # return to previous branch
    git checkout -

    # remove test branch
    git branch -D search-term-test-throwaway
}

@test "content matching search term prevents commit" {
    echo "FIXME:" > search-term-test-throwaway.txt
    git add search-term-test-throwaway.txt

    if ! git commit -m "add search term trigger"; then
        logTest "PASS"
    else
        logTest "FAIL"
        [ "$output" = "commit containing search term was allowed" ]
    fi
}

@test "content not matching search term is allowed" {
    echo "TODO": > search-term-test-throwaway.txt
    git add search-term-test-throwaway.txt

    if git commit -m "add content without search term"; then
        logTest "PASS"
    else
        logTest "FAIL"
        [ "$output" = "commit failed even without search term in content" ]
    fi
}
