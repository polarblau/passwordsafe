Feature: Remove
    In order to keep my password list up-to-date
    As a user
    I want to be able to remove a password

    Scenario: Remove a password
        Given A safe exists with masterpassword "masterpa$$" and a "name" key
        When I run `password remove name` interactively
        And I type "masterpa$$"
        Then the output should contain "entry has been removed"
        
    Scenario: Remove a password for a key that doesn't exist
        Given A safe exists with masterpassword "masterpa$$" and a "name" key
        When I run `password remove name2` interactively
        And I type "masterpa$$"
        Then the output should contain "name2 does not exist in this safe." 
