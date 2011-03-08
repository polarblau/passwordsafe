Feature: Add
    In order to store my passwords
    As a user
    I want to be able to add my passwords to the passwordsafe

    Scenario: Add a new password
        When I run "password add name pa$$word" interactively
        And I type "masterpa$$"
        Then the output should contain "password name added to safe"

    Scenario: Add a password with a name that exists
        Given A safe exists with masterpassword "masterpa$$" and a "name" key
        When I run "password add name pa$$word" interactively
        And I type "masterpa$$"
        Then the output should contain "Key already exists in keyring"
        And the output should not contain "password name added to safe"

