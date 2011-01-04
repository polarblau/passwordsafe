Feature: Get
    In order get my passwords out of the safe
    As a user
    I want to get my passwords from the password safe

    Scenario: Get a password with a name that exists
        Given A safe exists with masterpassword "masterpa$$" and a "name" key
        When I run "password get name" interactively
        And I type "masterpa$$"
        Then the output should contain "name: "

    Scenario: Get a password with a name that does not exist
        Given A safe exists with masterpassword "masterpa$$" and a "name" key
        When I run "password get name2" interactively
        And I type "masterpa$$"
        Then the output should contain "name2 does not exist in this safe."

