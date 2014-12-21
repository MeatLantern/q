Feature: Update Character

Background: Users has been logged in & character is already created
  Given I created an account
  And I am logged in
  And I have already created a character named "testUC1"
  And I am on the update character page for character "testUC1"

Scenario: Tried to update Character with too high of MP and HP
  When I have updated a character to max HP "90" and max MP "70"
  Then I should see the "Sum of Maximum HP and MP must be less than 150;" error

Scenario: Tried to update Character with too high of power, attack, defense and armor 
  When I have updated a character to base power "7", base attack "7", base defense "4" and base armor "4"
  Then I should see the "Sum of base power, attack, defense and armor must be less than 21;" error

Scenario: Tried to update Character with multiple of the same type of attack
  When I have updated a character to attack 1 "Heal" and attack 2 "Heal"
  Then I should see the "The rules selected for each action must be different;" error
