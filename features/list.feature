Feature: List
    In order to see what passwords I have stored
    As a user
    I want to be able to list existing password names

    Scenario: No passwords stored
        Given A safe exists with masterpassword "masterpa$$" and "0" keys
        When I run `password list` interactively
        And I type "masterpa$$"
        Then the output should contain "List: (none)"

    Scenario: One password stored
        Given A safe exists with masterpassword "masterpa$$" and a "pass" key
        When I run `password list` interactively
        And I type "masterpa$$"
        Then the output should contain "List: pass"

    Scenario: Several passwords stored
    Given A safe exists with masterpassword "masterpa$$" and the keys 
      |key     |
      |onekey  |
      |twokey  |
      |redkey  |
      |bluekey |
    When I run `password list` interactively
      And I type "masterpa$$"
    Then the output should contain "List: bluekey, onekey, redkey, twokey"

