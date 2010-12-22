Feature: Add
    In order to store my passwords
    As a user
    I want to be able to add my passwords to the passwordsafe


    Scenario: Add a new password
        When I run "password add name pa$$word" interactively
        And I type "masterpa$$"
        Then the output should contain "password name added to safe"

