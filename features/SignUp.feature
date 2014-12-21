Feature: user functionality

Background: users have been added to database

  Given I have created a user with username "test4" and email "test4@test4.com" and password "test4test4"

  And I am on the game rules page

Scenario:  Sign up for an account
  Given I am not authenticated
  When I have created a user with username "tester" and email "tester@tester.com" and password "testertester"
  Then I should see "Hello, tester"
  
Scenario: Log in to account
  Given I am not authenticated
  When I login with email "test4@test4.com" and password "test4test4"
  Then I should see "Hello, test4"
  
Scenario: Logout
  Given I am not authenticated
  When I login with email "test4@test4.com" and password "test4test4"
  Then I press logout
  Then I should not see "Hello, test4"
