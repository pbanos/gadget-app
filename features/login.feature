Feature: Log in
As a registered user
I want to log in
So that I can see my gadgets

Scenario: Successful login
Given a 'pbanos' user exists with password 'Secret.123'
And I am not currently logged in
When I go to the login page
Then I should see "Log in"
When I fill in 'Username' with "pbanos"
And I fill in 'Password' with "Secret.123"
And I press "Log in"
Then I should be at the user page
And I should see "Welcome, pbanos"

Scenario: Unexistent user login
Given no 'pbanos' user exists
And I am not currently logged in
When I go to the login page
Then I should see "Log in"
When I fill in 'Username' with "pbanos"
And I fill in 'Password' with "Secret.123"
And I press "Log in"
Then I should be at the signup page
And I should see "Invalid username or password"

Scenario: Wrong password login
Given a 'pbanos' user exists with password 'Secret.1234'
And I am not currently logged in
When I go to the login page
Then I should see "Log in"
When I fill in 'Username' with "pbanos"
And I fill in 'Password' with "Secret.123"
And I press "Log in"
Then I should be at the signup page
And I should see "Invalid username or password"