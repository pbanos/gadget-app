Given(/^I am authenticated as '([^']+)'$/) do |username|
  step("a '#{username}' user exists with password 'Secret.123'")
  user = User.find_by username: username
  step('I am not currently logged in')
  step('I go to the login page')
  step("I fill in 'Username' with \"#{user.username}\"")
  step("I fill in 'Password' with \"Secret.123\"")
  step('I press "Log in"')
end

Given(/^the user "(.*?)" has as gadgets$/) do |username, table|
  step("a '#{username}' user exists")
  user = User.find_by username: username
  Gadget.where(user_id: user.id).destroy_all
  table.rows.flatten.each do |gadget_name|
  	Gadget.create(user: user, name: gadget_name)
  end
end

When(/^I go to the user page$/) do
  visit '/'
end

Then(/^I should see the gadgets$/) do |table|
  table.rows.flatten.each do |gadget_name|
  	page.should have_content(gadget_name)
  end
end

Then(/^I should not see the gadgets$/) do |table|
  listed_gadget_names = page.all(:xpath, '//table/tbody/tr/td[1]').map(&:text)
  table.rows.flatten.each do |gadget_name|
  	listed_gadget_names.should_not include(gadget_name)
  end
end


When(/^I follow "(.*?)"$/) do |link|
  click_link(link)
end

Then(/^the user "(.*?)" should have the following gadgets$/) do |username, table|
  user = User.find_by username: username
  (table.rows.flatten - user.gadgets.map(&:name)).should be_empty
  (user.gadgets.map(&:name) - table.rows.flatten).should be_empty
end

Then(/^the user "(.*?)" should have (\d+) gadgets$/) do |username, gadgets_number|
  user = User.find_by username: username
  user.gadgets.count.should == gadgets_number.to_i
end

When(/^I fill in "(.*?)" in the search box$/) do |query|
  step("I fill in 'Search for:' with \"#{query}\"")
end

Then(/^I should see no gadgets$/) do
  listed_gadget_names = page.all(:xpath, '//table/tbody/tr/td[1]').map(&:text)
  listed_gadget_names.should be_empty
end

When(/^I follow "(.*?)" on the gadget "(.*?)" row$/) do |link, gadget_name|
  within :xpath, "/html/body/div/table/tbody/tr[.//text()='#{gadget_name}' and .//a[text()='#{link}']]" do
    click_link(link)
  end
end

Then(/^the field "(.*?)" should contain "(.*?)"$/) do |field, content|
  field_labeled(field).value.should == content
end

Then(/^I should be on the root page$/) do
  URI.parse(current_url).path.should == '/'
end