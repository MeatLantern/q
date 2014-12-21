Feature: admin functionality

Background: users have been added to database

  Given I have created a new user with username "test_user" and email "test@user.com" and password "test_user"
  And I have created an admin with username "admin" and email "admin@test.com" and password "admin_test"

Scenario: Make a user an admin
  When I login as an admin with email "admin@test.com" and password "admin_test"
  When I am on the users admin page
  When I click to make the user with username "test_user" an admin
  Then I should see user "test_user" with email "test@user.com" as an admin
  Then I press the logout button

Scenario: Delete a user
  When I login as an admin with email "admin@test.com" and password "admin_test"
  Given I am on the users admin page
  When I click to delete the user with username "test_user"
  Then I should not see the user "test_user" anymore
  Then I press the logout button
