Given(/^no '([^']+)' user exists$/) do |username|
  if user = User.find_by(username: username)
    user.destroy
  end
end

Given(/^I am not currently logged in$/) do
  visit '/users/sign_out'
end

When(/^I go to the signup page$/) do
  visit '/users/sign_up'
end

Then(/^I should see "(.*?)"$/) do |text|
  page.should have_content(text)
end

When(/^I fill in '([^']+)' with "(.*?)"$/) do |field, content|
  fill_in(field, with: content)
end

When(/^I press "(.*?)"$/) do |button|
  click_button(button)
end

Then(/^there should be a '([^']+)' user$/) do |username|
  User.find_by(username: username).should_not be_nil
end

Then(/^I should be at the user page$/) do
  URI.parse(current_url).path.should == '/'
end

Given(/^a '([^']+)' user exists$/) do |username|
  unless user = User.find_by(username: username)
    FactoryGirl.create(:user, username: username)
  end
end

Then(/^I should be at the signup page$/) do
   %w(/users /users/sign_up).should include(URI.parse(current_url).path)
end

Then(/^there should be no '([^']+)' user$/) do |username|
  User.find_by(username: username).should be_nil
end