Feature: Add
    In order to store a safe password
    As a user
    I want to be able to create a safe password and store it

    Scenario: Create and add new password
        When I run "password create name" interactively
        And I type "masterpa$$"
        Then the output should contain "generated and added to safe"
 
    Scenario: Generate a password with a certain length
        When I run "password create name --length 12" interactively
        And I type "masterpa$$"
        Then the output should contain "generated and added to safe"
       
    Scenario: Generate a password with a name that exists
        Given A safe exists with masterpassword "masterpa$$" and a "name" key
        When I run "password create name" interactively
        And I type "masterpa$$"
        Then the output should contain "Key already exists in keyring"
        And the output should not contain "generated and added to safe"
        
      
