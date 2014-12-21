Given /^I created an account$/ do
  visit '/users/sign_up'
  fill_in 'user_email', :with => 'testChar@testChar.com'
  fill_in 'user_username', :with => 'testChar'
  fill_in 'user_password', :with => 'password'
  fill_in 'user_password_confirmation', :with => 'password'
  click_button 'Sign up'
end

And /^I am logged in$/ do
  click_button 'Logout'
  visit '/users/sign_in'
  fill_in 'user_email', :with => 'testChar@testChar.com'
  fill_in 'user_password', :with => 'password'
  click_button 'Log in'
end

And /^I am on the create character page$/ do
  visit '/characters/new'
end



And /^I have already created a character named "(.*?)"$/ do |char|
  create_hash = {:name => char, :description => "desc", :max_hp => 100, :max_mp => 50, :base_attack => 5, :base_power => 7, :base_defense => 5, :base_armor => 4, :actions => "A1, A2, A3, A4", :main_image => "", :action_1_id => 5, :action_1_name => "A1", :action_1_flavor => "do A1", :action_1_rules => "Powerful Attack", :action_2_id => 6, :action_2_name => "A2", :action_2_flavor => "do A2", :action_2_rules => "Reckless Attack", :action_3_id => 7, :action_3_name => "A3", :action_3_flavor => "do A3", :action_3_rules => "Overwhelming Attack", :action_4_id => 8, :action_4_name => "A4", :action_4_flavor => "do A4", :action_4_rules => "Focusing Action", :summon_name => "", :summon_attack => "", :summon_picture => "", :creator => ""}
  Character.create!(create_hash)
end

And /^I am on the update character page for character "(.*?)"$/ do |char|
  visit '/character/edit?name=char'
end

When /^I have created a character with name "(.*?)" and everything else filled out$/ do |name|
  fill_in 'character_name', :with => name
  fill_in 'character_description', :with => 'Desc'
  select '100', :from => 'character_max_hp'
  select '50', :from => 'character_max_mp'
  select '5', :from => 'character_base_power'
  select '5', :from => 'character_base_attack'
  select '5', :from => 'character_base_defense'
  select '5', :from => 'character_base_armor'
  fill_in 'character_action_1_name', :with => "A1"
  fill_in 'character_action_1_flavor', :with => "A1 flav"
  fill_in 'character_action_2_name', :with => "A2"
  fill_in 'character_action_2_flavor', :with => "A2 flav"
  select 'Charge', :from => 'character_action_2_rules'
  fill_in 'character_action_3_name', :with => "A3"
  fill_in 'character_action_3_flavor', :with => "A3 flav"
  select 'Locking Attack', :from => 'character_action_3_rules'
  fill_in 'character_action_4_name', :with => "A4"
  fill_in 'character_action_4_flavor', :with => "A4 flav"
  select 'Confusing Attack', :from => 'character_action_4_rules'
  fill_in 'character_main_image', :with => "http://url.com"

  click_button 'Create Character'
end

Then /^I should see "(.*?)" in the Character table$/ do |name|
  expect(page).to have_content(name)
end

When /^I have created a character with name "(.*?)" and nothing else specified$/ do |name|
  fill_in 'character_name', :with => name

  click_button 'Create Character'
end

Then /^I should see "ERROR" and a list of what must be entered$/ do
  expect(page).to have_content("A description must be entered;") 
end

When /^I have created a character with base power "(.*?)", base attack "(.*?)", base defense "(.*?)" and base armor "(.*?)"$/ do |power, attack, defense, armor|
  fill_in 'character_name', :with => 'Name'
  fill_in 'character_description', :with => 'Desc'
  select '100', :from => 'character_max_hp'
  select '50', :from => 'character_max_mp'
  select power, :from => 'character_base_power'
  select attack, :from => 'character_base_attack'
  select defense, :from => 'character_base_defense'
  select armor, :from => 'character_base_armor'
  fill_in 'character_action_1_name', :with => "A1"
  fill_in 'character_action_1_flavor', :with => "A1 flav"
  fill_in 'character_action_2_name', :with => "A2"
  fill_in 'character_action_2_flavor', :with => "A2 flav"
  select 'Charge', :from => 'character_action_2_rules'
  fill_in 'character_action_3_name', :with => "A3"
  fill_in 'character_action_3_flavor', :with => "A3 flav"
  select 'Locking Attack', :from => 'character_action_3_rules'
  fill_in 'character_action_4_name', :with => "A4"
  fill_in 'character_action_4_flavor', :with => "A4 flav"
  select 'Confusing Attack', :from => 'character_action_4_rules'
  fill_in 'character_main_image', :with => "http://url.com"

  click_button 'Create Character'
end

When /^I have created a character with max HP "(.*?)" and max MP "(.*?)"$/ do |hp, mp|
  fill_in 'character_name', :with => 'Name'
  fill_in 'character_description', :with => 'Desc'
  select hp, :from => 'character_max_hp'
  select mp, :from => 'character_max_mp'
  fill_in 'character_action_1_name', :with => "A1"
  fill_in 'character_action_1_flavor', :with => "A1 flav"
  fill_in 'character_action_2_name', :with => "A2"
  fill_in 'character_action_2_flavor', :with => "A2 flav"
  select 'Charge', :from => 'character_action_2_rules'
  fill_in 'character_action_3_name', :with => "A3"
  fill_in 'character_action_3_flavor', :with => "A3 flav"
  select 'Locking Attack', :from => 'character_action_3_rules'
  fill_in 'character_action_4_name', :with => "A4"
  fill_in 'character_action_4_flavor', :with => "A4 flav"
  select 'Confusing Attack', :from => 'character_action_4_rules'
  fill_in 'character_main_image', :with => "http://url.com"

  click_button 'Create Character'
end

When /^I have created a character with attack 1 "(.*?)" and attack 2 "(.*?)"$/ do |a1Rule, a2Rule|
  fill_in 'character_name', :with => 'Name'
  fill_in 'character_description', :with => 'Desc'
  fill_in 'character_action_1_name', :with => "A1"
  fill_in 'character_action_1_flavor', :with => "A1 flav"
  fill_in 'character_action_2_name', :with => "A2"
  fill_in 'character_action_2_flavor', :with => "A2 flav"
  select  a1Rule, :from => 'character_action_2_rules'
  fill_in 'character_action_3_name', :with => "A3"
  fill_in 'character_action_3_flavor', :with => "A3 flav"
  select a2Rule, :from => 'character_action_3_rules'
  fill_in 'character_action_4_name', :with => "A4"
  fill_in 'character_action_4_flavor', :with => "A4 flav"
  select 'Confusing Attack', :from => 'character_action_4_rules'
  fill_in 'character_main_image', :with => "http://url.com"  

  click_button 'Create Character'
end



When /^I have updated a character to base power "(.*?)", base attack "(.*?)", base defense "(.*?)" and base armor "(.*?)"$/ do |power, attack, defense, armor|
  fill_in 'character_name', :with => 'Name'
  fill_in 'character_description', :with => 'Desc'
  select '100', :from => 'character_max_hp'
  select '50', :from => 'character_max_mp'
  select power, :from => 'character_base_power'
  select attack, :from => 'character_base_attack'
  select defense, :from => 'character_base_defense'
  select armor, :from => 'character_base_armor'
  fill_in 'character_action_1_name', :with => "A1"
  fill_in 'character_action_1_flavor', :with => "A1 flav"
  fill_in 'character_action_2_name', :with => "A2"
  fill_in 'character_action_2_flavor', :with => "A2 flav"
  select 'Charge', :from => 'character_action_2_rules'
  fill_in 'character_action_3_name', :with => "A3"
  fill_in 'character_action_3_flavor', :with => "A3 flav"
  select 'Locking Attack', :from => 'character_action_3_rules'
  fill_in 'character_action_4_name', :with => "A4"
  fill_in 'character_action_4_flavor', :with => "A4 flav"
  select 'Confusing Attack', :from => 'character_action_4_rules'
  fill_in 'character_main_image', :with => "http://url.com"

  click_button 'Update Character'
end

When /^I have updated a character to max HP "(.*?)" and max MP "(.*?)"$/ do |hp, mp|
  fill_in 'character_name', :with => 'Name'
  fill_in 'character_description', :with => 'Desc'
  select hp, :from => 'character_max_hp'
  select mp, :from => 'character_max_mp'
  fill_in 'character_action_1_name', :with => "A1"
  fill_in 'character_action_1_flavor', :with => "A1 flav"
  fill_in 'character_action_2_name', :with => "A2"
  fill_in 'character_action_2_flavor', :with => "A2 flav"
  select 'Charge', :from => 'character_action_2_rules'
  fill_in 'character_action_3_name', :with => "A3"
  fill_in 'character_action_3_flavor', :with => "A3 flav"
  select 'Locking Attack', :from => 'character_action_3_rules'
  fill_in 'character_action_4_name', :with => "A4"
  fill_in 'character_action_4_flavor', :with => "A4 flav"
  select 'Confusing Attack', :from => 'character_action_4_rules'
  fill_in 'character_main_image', :with => "http://url.com"  

  click_button 'Update Character'
end

When /^I have updated a character to attack 1 "(.*?)" and attack 2 "(.*?)"$/ do |a1Rule, a2Rule|
  fill_in 'character_name', :with => 'Name'
  fill_in 'character_description', :with => 'Desc'
  fill_in 'character_action_1_name', :with => "A1"
  fill_in 'character_action_1_flavor', :with => "A1 flav"
  select a1Rule, :from => 'character_action_1_rules'
  fill_in 'character_action_2_name', :with => "A2"
  fill_in 'character_action_2_flavor', :with => "A2 flav"
  select a2Rule, :from => 'character_action_2_rules'
  fill_in 'character_action_3_name', :with => "A3"
  fill_in 'character_action_3_flavor', :with => "A3 flav"
  select 'Locking Attack', :from => 'character_action_3_rules'
  fill_in 'character_action_4_name', :with => "A4"
  fill_in 'character_action_4_flavor', :with => "A4 flav"
  select 'Confusing Attack', :from => 'character_action_4_rules'
  fill_in 'character_main_image', :with => "http://url.com"  

  click_button 'Update Character'
end

Then /^I should see the "(.*?)" error$/ do |error|
  expect(page).to have_content(error) 
end
