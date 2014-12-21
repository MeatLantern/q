
When /^I have created a new user with username "(.*?)" and email "(.*?)" and password "(.*?)"$/ do |username, email, password|
  user = User.new(:username => username,
                  :email => email,
                  :password => password,
                  :password_confirmation => password)
  user.save!
end

When /^I have created an admin with username "(.*?)" and email "(.*?)" and password "(.*?)"$/ do |username, email, password|
  user = User.new(:username => username,
                  :email => email,
                  :password => password,
                  :password_confirmation => password,
                  :is_admin => true)
  user.save!
end

Then /^I press the logout button$/ do
  click_button 'Logout'
end

When /^I login as an admin with email "(.*?)" and password "(.*?)"$/ do |email, password|
  visit '/users/sign_in'
  fill_in 'email', :with => email
  fill_in 'password', :with => password
  click_button 'Log in'
end

When /^I am on the users admin page$/ do
  visit '/users/admin'
end

When /^I click to delete the user with username "(.*?)"$/ do |user|
  user = User.find_by_username(user)
  page.driver.submit :delete, "/users/#{user.id}", { }
end

Then /^I should not see the user "(.*?)" anymore$/ do |user|
  expect(page).not_to have_content(user)
end

When /^I click to make the user with username "(.*?)" an admin$/ do |user|
  user = User.find_by_username(user)
  find(:xpath, "//a[@href='/users/add_admin?id=#{user.id}']").click
end

Then /^I should see user "(.*?)" with email "(.*?)" as an admin$/ do |user, email|
  expect(page).to have_content("#{user} #{email} remove")
end