Feature: View gadgets
As an authenticated user
I want to view my gadgets
So that I can manage them

Scenario: List own gadgets
Given I am authenticated as 'pbanos'
And the user "pbanos" has as gadgets
	| Name 	|
	| g1	|
	| g2	|
	| g3	|
And the user "other" has as gadgets
	| Name 	|
	| g4	|
	| g5	|
	| g6	|
When I go to the user page
Then I should see the gadgets
	| Name 	|
	| g1	|
	| g2	|
	| g3	|
But I should not see the gadgets
	| Name 	|
	| g4	|
	| g5	|
	| g6	|
