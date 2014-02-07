Feature: Sign up
As a non-registered user
I want to sign up
So that I can log in

Scenario: Successful signup
Given no 'pbanos' user exists
And I am not currently logged in
When I go to the signup page
Then I should see "Sign up"
When I fill in 'Username' with "pbanos"
And I fill in 'Password' with "Secret.123"
And I fill in 'Password confirmation' with "Secret.123"
And I press "Sign up"
Then there should be a 'pbanos' user 
And I should be at the user page
And I should see "Welcome, pbanos"

Scenario: Usename taken
Given a 'pbanos' user exists
And I am not currently logged in
When I go to the signup page
Then I should see "Sign up"
When I fill in 'Username' with "pbanos"
And I fill in 'Password' with "Secret.123"
And I fill in 'Password confirmation' with "Secret.123"
And I press "Sign up"
Then there should be a 'pbanos' user 
But I should be at the signup page
And I should see "Username taken"

Scenario: Password does not match confirmation
Given no 'pbanos' user exists
And I am not currently logged in
When I go to the signup page
Then I should see "Sign up"
When I fill in 'Username' with "pbanos"
And I fill in 'Password' with "Secret.123"
And I fill in 'Password confirmation' with "Secret.1234"
And I press "Sign up"
Then there should be no 'pbanos' user 
And I should be at the signup page
And I should see "Password doesn't match confirmation"