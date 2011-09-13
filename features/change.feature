Feature: Add
    In order to not having to remove and re-add my passwords
    As a user
    I want to be able to change a password

    Scenario: Change password
        Given A safe exists with masterpassword "masterpa$$" and a "name" key
        When I run `password change name newpa$$word` interactively
        And I type "masterpa$$"
        Then the output should contain "password for name has been updated"

    Scenario: Change a password for a key that doesn't exist
        Given A safe exists with masterpassword "masterpa$$" and a "name" key
        When I run `password change name2 newpa$$word` interactively
        And I type "masterpa$$"
        Then the output should contain "name2 does not exist in this safe."
