Given(/^I am authenticated as '([^']+)'$/) do |username|
  step("a '#{username}' user exists")
  user = User.find_by username: username
  step('I am not currently logged in')
  step('I go to the login page')
  step("I fill in 'Username' with \"#{user.username}\"")
  step("I fill in 'Password' with \"#{user.password}\"")
  step('I press "Log in"')
end

Given(/^the user "(.*?)" has as gadgets$/) do |username, table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

When(/^I go to the user page$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see the gadgets$/) do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

Then(/^I should not see the gadgets$/) do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end
