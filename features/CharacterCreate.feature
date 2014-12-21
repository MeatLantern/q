Feature: Create Character

Background: users have been added to database
  Given I created an account
  And I am logged in
  And I am on the create character page

Scenario:  Create a new Character with valid info
  When I have created a character with name "JON" and everything else filled out
  Then I should see "JON" in the Character table

Scenario: Tried to create Character with missing info
  When I have created a character with name "Dude" and nothing else specified
  Then I should see "ERROR" and a list of what must be entered

Scenario: Tried to create Character with too high of MP and HP
  When I have created a character with max HP "90" and max MP "70"
  Then I should see the "ERROR: Sum of Maximum HP and MP must be less than 150;" error

Scenario: Tried to create Character with too high of power, attack, defense and armor 
  When I have created a character with base power "7", base attack "7", base defense "4" and base armor "4"
  Then I should see the "ERROR: Sum of base power, attack, defense and armor must be less than 21" error

Scenario: Tried to create Character with multiple of the same type of attack
  When I have created a character with attack 1 "Heal" and attack 2 "Heal"
  Then I should see the "ERROR: The rules selected for each action must be different" error
