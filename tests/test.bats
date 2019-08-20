#!/usr/bin/env bats

teardown() {
    echo "Tearing stuff down..."
    $(git config user.name Lauren Stephenson)
}

@test "correct name" {
    testName="Lauren Stephenson"
   # $(git config user.name Pablaaao)

    [[ "$(git config user.name)" == $testName ]]
}

@test "incorrect name" {
    testName="First Last"

    [[ "$(git config user.name)" != $testName ]]
}

@test "correct email" {
    testEmail="compscilauren@gmail.com"

    [[ "$(git config user.email)" == $testEmail ]]
}

@test "incorrect email" {
    testEmail="first.last@gmail.com"

    [[ "$(git config user.email)" != $testEmail ]]
}
