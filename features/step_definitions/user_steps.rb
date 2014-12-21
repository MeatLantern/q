
Given /^I am on the game rules page$/ do
  visit '/game/rules'
end

Given /^I am not authenticated$/ do
  click_button 'Logout'
end
  

 
When /^I have created a user with username "(.*?)" and email "(.*?)" and password "(.*?)"$/ do |username, email, password|
  visit '/users/sign_up'
  fill_in 'email', :with => email
  fill_in 'username', :with => username
  fill_in 'password', :with => password
  fill_in 'password_confirmation', :with => password
  click_button 'Sign up'
end

Then /^I should see "(.*?)"$/ do |text|
  expect(page).to have_content(text)
end

When /^I login with email "(.*?)" and password "(.*?)"$/ do |email, password|
  visit '/users/sign_in'
  fill_in 'email', :with => email
  fill_in 'password', :with => password
  click_button 'Log in'
end

Then /^I press logout$/ do
  click_button 'Logout'
end

Then /^I should not see "(.*?)"$/ do |test|
  expect(page).not_to have_content(test)
end


