Given(/^a '([^']+)' user exists with password '([^']+)'$/) do |username, password|
  step("no '#{username}' user exists")
  FactoryGirl.create(:user, username: username, password: password)
end

When(/^I go to the login page$/) do
  visit '/users/sign_in'
end

Then(/^I should be at the login page$/) do
  URI.parse(current_url).path.should == '/users/sign_in'
end
