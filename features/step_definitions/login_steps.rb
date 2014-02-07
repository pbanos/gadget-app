Given(/^a '([^']+)' user exists with password '([^']+)'$/) do |username, password|
  step("no '#{username}' user exists")
  FactoryGirl.create(:user, username: username, password: password)
end

When(/^I go to the login page$/) do
  visit '/users/sign_in'
end