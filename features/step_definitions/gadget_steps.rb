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

Given(/^the gadget "(.*?)" belonging to "(.*?)" has the following images$/) do |gadget_name, username, table|
  user = User.find_by username: username
  gadget = user.gadgets.find_by name: gadget_name
  table.rows.flatten.map do |image_filename|
    gadget.gadget_images.create(attachment: File.new(File.join('features/images', image_filename)))
  end
end

Then(/^I should see the following images$/) do |table|
  page_images = page.all(:xpath, "//img").map do |image_tag|
    image_tag['src']
  end.map do |image_source|
    image_source.split('?').first.split('/').last
  end
  (table.rows.flatten - page_images).should be_empty
end

When(/^I upload the file "(.*?)"$/) do |image_filename|
  attach_file(:gadget_image_attachment, File.join('features/images', image_filename))
  click_button "Send file"
end

When(/^I follow the "(.*?)" link for image "(.*?)"$/) do |link, image_filename|
  within :xpath, "//div[./img[contains(./@src, '#{image_filename}')] and .//a[text()='#{link}']]" do
    click_link(link)
  end
end

Then(/^I should not see image "(.*?)"$/) do |image_filename|
  page_images = page.all(:xpath, "//img").map do |image_tag|
    image_tag['src']
  end.map do |image_source|
    image_source.split('?').first.split('/').last
  end
  page_images.should_not include(image_filename)
end