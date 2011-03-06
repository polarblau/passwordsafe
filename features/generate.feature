Feature: Add
    In order to store a safe password
    As a user
    I want to be able to generate a safe password and store it

    Scenario: Generate and add new password
        Given A safe exists with masterpassword "masterpa$$"
        When I run "password generate name" interactively
        And I type "masterpa$$"
        Then the output should contain "generated and added to safe"
        And the clipboard should contain the password for the "name" key
 
    Scenario: Generate a password with a certain length
      Given A safe exists with masterpassword "masterpa$$"
        When I run "password generate name --length 12" interactively
        And I type "masterpa$$"
        Then the output should contain "generated and added to safe"
        And the clipboard should contain the password for the "name" key
       
    Scenario: Generate a password with a name that exists
        Given A safe exists with masterpassword "masterpa$$" and a "name" key
        When I run "password generate name" interactively
        And I type "masterpa$$"
        Then the output should contain "Key already exists in keyring"
        And the output should not contain "generated and added to safe"
        
      
