#!/usr/bin/env bats

LOG="./tests/tests.log"

logTest() {
    # $1 indicates the test status [PASS, FAIL]
    date >> "$LOG"
    echo "missing aspell error test: $1" >> "$LOG"
    echo "" >> "$LOG"
    echo "--------------------------------------------" >> "$LOG"
    echo "" >> "$LOG"
}

setup() {
    # Create demo .md files to test against
    correctSentence="This sentence is correct and working"
    misspelledSentence="Tihs nto as muhc and migth have probelms"
    otherLangSentence="人間にとっての小さな一歩、人類にとっての大きな飛躍"
    echo $correctSentence > proper.md
    echo $misspelledSentence > faulty.md
    echo $otherLangSentence > other_lang.md
}

teardown() {
    # Remove demo .md files
    rm proper.md faulty.md other_lang.md
}

# Verifies that aspell is installed on the hosts system.
@test "aspell not found error" {
    run aspell -v
    if [ "$status" -eq 0 ]; then
        logTest "PASS"
    else
        logTest "FAIL"
        [ "$output" = "aspell is not installed" ]
    fi
}

# Verifies that aspell works against proper spelling
@test "spellcheck proper md" {
    runAspell=$(cat proper.md | aspell --lang=en list)
    if [ -z "$runAspell" ]; then
        logTest "PASS"
    else
        logTest "FAIL"
        [ "$output" = "aspell found spelling mistakes" ]
    fi
}

# Verifies that aspell works against miss-spelling
@test "spellcheck faulty md" {
    runAspell=$(cat faulty.md | aspell --lang=en list)
    if [ -n "$runAspell" ]; then
        logTest "PASS"
    else
        logTest "FAIL"
        [ "$output" = "aspell didn't find spelling mistakes" ]
    fi
}

# Verifies that aspell checks only english
@test "unsupported language error" {
    runAspell=$(cat other_lang.md | aspell --lang=en list)
    if [ -z "$runAspell" ]; then
        logTest "PASS"
    else
        logTest "FAIL"
        [ "$output" = "aspell found spelling mistakes in unsupported lang" ]
    fi
}
