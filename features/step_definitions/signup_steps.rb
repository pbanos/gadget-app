Given(/^no '([^']+)' user exists$/) do |username|
  if user = User.find_by(username: username)
    user.destroy
  end
end

Given(/^I am not currently logged in$/) do
  visit '/users/sign_out'
end

When(/^I go to the signup page$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^I fill in 'Username' with "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^I fill in 'Password' with "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^I fill in 'Password confirmation' with "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^I press "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^there should be a 'pbanos' user$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should be at the user page$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^a '([^']+)' user exists$/) do |username|
  unless user = User.find_by(username: username)
    FactoryGirl.create(:user, username: username)
  end
end

Then(/^I should be at the signup page$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^there should be no '([^']+)' user$/) do |username|
  pending # express the regexp above with the code you wish you had
end