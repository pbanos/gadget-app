Feature: Manage gadgets
As an authenticated user
I want to search, list, show in cover flow, create, edit and destroy my gadgets
So that I can manage my electronic gadget collection

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

Scenario: Successful gadget creation
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
And I follow "Create Gadget"
Then I should see "New Gadget"
When I fill in 'Name' with "g4"
And I press "Create gadget"
Then the user "pbanos" should have the following gadgets
	| Name 	|
	| g1	|
	| g2	|
	| g3	|
	| g4	| 
And I should be at the user page
And I should see the gadgets
	| Name 	|
	| g1	|
	| g2	|
	| g3	|
	| g4	|

Scenario: Invalid gadget creation
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
And I follow "Create Gadget"
Then I should see "New Gadget"
When I fill in 'Name' with "g3"
And I press "Create gadget"
Then I should see "New Gadget"
And I should see "Name has already been taken"
And the user "pbanos" should have 3 gadgets 

Scenario: Successful gadget search
Given I am authenticated as 'pbanos'
And the user "pbanos" has as gadgets
	| Name 	|
	| g1	|
	| g12	|
	| g123	|
And the user "other" has as gadgets
	| Name 	|
	| g124	|
	| g125	|
	| g126	|
When I go to the user page
And I fill in "g12" in the search box
And I press "Search"
Then I should see the gadgets
	| Name 	|
	| g12	|
	| g123	|
But I should not see the gadgets
	| Name 	|
	| g1	|
	| g124	|
	| g125	|
	| g126	|

Scenario: Unsuccessful gadget search
Given I am authenticated as 'pbanos'
And the user "pbanos" has as gadgets
	| Name 	|
	| g1	|
	| g2	|
	| g3	|
And the user "other" has as gadgets
	| Name 	|
	| g124	|
	| g125	|
	| g126	|
When I go to the user page
And I fill in "g12" in the search box
And I press "Search"
Then I should see no gadgets

Scenario: Successful gadget rename
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
And I follow "Edit" on the gadget "g2" row
Then I should see "Edit Gadget"
Then the field "Name" should contain "g2"
When I fill in 'Name' with "g7"
And I press "Update"
Then the user "pbanos" should have the following gadgets
	| Name 	|
	| g1	|
	| g7	|
	| g3	|
And I should be on the root page
And I should see the gadgets
	| Name 	|
	| g1	|
	| g7	|
	| g3	|

Scenario: Invalid gadget rename
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
And I follow "Edit" on the gadget "g2" row
Then I should see "Edit Gadget"
Then the field "Name" should contain "g2"
When I fill in 'Name' with "g3"
And I press "Update"
Then the user "pbanos" should have the following gadgets
	| Name 	|
	| g1	|
	| g2	|
	| g3	|
And I should see "Edit Gadget"
When I go to the user page
Then I should see the gadgets
	| Name 	|
	| g1	|
	| g2	|
	| g3	|

Scenario: Add image to gadget

Scenario: Destroy gadget image

Scenario: Destroy gadget without images

Scenario: Destroy gadget with images

Scenario: Show gadgets in small size cover flow

Scenario: Show gadgets in medium size cover flow

Scenario: Show gadgets in large size cover flow

