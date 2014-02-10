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

Scenario: See the images of a gadget
Given I am authenticated as 'pbanos'
And the user "pbanos" has as gadgets
	| Name 	|
	| g1	|
	| g2	|
	| g3	|
And the gadget "g2" belonging to "pbanos" has the following images
	| Image 	  |
	| image-1.jpg |
	| image-2.jpg |
	| image-3.jpg |
And the user "other" has as gadgets
	| Name 	|
	| g4	|
	| g5	|
	| g6	|
When I go to the user page
And I follow "Edit" on the gadget "g2" row
Then I should see "Edit Gadget"
And I should see the following images
	| Image 	  |
	| image-1.jpg |
	| image-2.jpg |
	| image-3.jpg |


Scenario: Add image to gadget
Given I am authenticated as 'pbanos'
And the user "pbanos" has as gadgets
	| Name 	|
	| g1	|
	| g2	|
	| g3	|
And the gadget "g2" belonging to "pbanos" has the following images
	| Image 	  |
	| image-1.jpg |
	| image-2.jpg |
	| image-3.jpg |
And the user "other" has as gadgets
	| Name 	|
	| g4	|
	| g5	|
	| g6	|
When I go to the user page
And I follow "Edit" on the gadget "g2" row
Then I should see "Edit Gadget"
And I should see the following images
	| Image 	  |
	| image-1.jpg |
	| image-2.jpg |
	| image-3.jpg |
When I upload the file "image-4.jpg"
Then I should see "Edit Gadget"
Then the field "Name" should contain "g2"
And I should see the following images
	| Image 	  |
	| image-1.jpg |
	| image-2.jpg |
	| image-3.jpg |
	| image-4.jpg |

Scenario: Destroy gadget image
Given I am authenticated as 'pbanos'
And the user "pbanos" has as gadgets
	| Name 	|
	| g1	|
	| g2	|
	| g3	|
And the gadget "g2" belonging to "pbanos" has the following images
	| Image 	  |
	| image-1.jpg |
	| image-2.jpg |
	| image-3.jpg |
And the user "other" has as gadgets
	| Name 	|
	| g4	|
	| g5	|
	| g6	|
When I go to the user page
And I follow "Edit" on the gadget "g2" row
Then I should see "Edit Gadget"
When I follow the "Destroy" link for image "image-2.jpg"
Then I should see "Edit Gadget"
Then the field "Name" should contain "g2"
And I should see the following images
	| Image 	  |
	| image-1.jpg |
	| image-3.jpg |
And I should not see image "image-2.jpg"

Scenario: Destroy gadget without images
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
And I follow "Destroy" on the gadget "g1" row
Then the user "pbanos" should have the following gadgets
	| Name 	|
	| g2	|
	| g3	| 
And I should be at the user page
And I should see the gadgets
	| Name 	|
	| g2	|
	| g3	|

Scenario: Destroy gadget with images
Given I am authenticated as 'pbanos'
And the user "pbanos" has as gadgets
	| Name 	|
	| g1	|
	| g2	|
	| g3	|
And the gadget "g2" belonging to "pbanos" has the following images
	| Image 	  |
	| image-1.jpg |
	| image-2.jpg |
	| image-3.jpg |
And the user "other" has as gadgets
	| Name 	|
	| g4	|
	| g5	|
	| g6	|
When I go to the user page
And I follow "Destroy" on the gadget "g1" row
Then the user "pbanos" should have the following gadgets
	| Name 	|
	| g2	|
	| g3	| 
And I should be at the user page
And I should see the gadgets
	| Name 	|
	| g2	|
	| g3	|

Scenario: Show gadgets in thumbnail size cover flow
Given I am authenticated as 'pbanos'
And the user "pbanos" has as gadgets
	| Name 	|
	| g1	|
	| g2	|
	| g3	|
And the gadget "g1" belonging to "pbanos" has the following images
	| Image 	  |
	| image-1.jpg |
And the gadget "g2" belonging to "pbanos" has the following images
	| Image 	  |
	| image-2.jpg |
And the user "other" has as gadgets
	| Name 	|
	| g4	|
	| g5	|
	| g6	|
And the gadget "g4" belonging to "other" has the following images
	| Image 	  |
	| image-3.jpg |
And the gadget "g5" belonging to "other" has the following images
	| Image 	  |
	| image-3.jpg |
When I go to the user page
And I follow "Small cover flow"
Then I should see the following images
	| Image 	  |
	| image-1.jpg |
	| image-2.jpg |
And I should not see image "image-3.jpg"
And all the images should be thumbnail-sized

Scenario: Show gadgets in medium size cover flow
Given I am authenticated as 'pbanos'
And the user "pbanos" has as gadgets
	| Name 	|
	| g1	|
	| g2	|
	| g3	|
And the gadget "g1" belonging to "pbanos" has the following images
	| Image 	  |
	| image-1.jpg |
And the gadget "g2" belonging to "pbanos" has the following images
	| Image 	  |
	| image-2.jpg |
And the user "other" has as gadgets
	| Name 	|
	| g4	|
	| g5	|
	| g6	|
And the gadget "g4" belonging to "other" has the following images
	| Image 	  |
	| image-3.jpg |
And the gadget "g5" belonging to "other" has the following images
	| Image 	  |
	| image-3.jpg |
When I go to the user page
And I follow "Small cover flow"
Then I should see the following images
	| Image 	  |
	| image-1.jpg |
	| image-2.jpg |
And I should not see image "image-3.jpg"
And all the images should be medium-sized

Scenario: Show gadgets in original size cover flow
Given I am authenticated as 'pbanos'
And the user "pbanos" has as gadgets
	| Name 	|
	| g1	|
	| g2	|
	| g3	|
And the gadget "g1" belonging to "pbanos" has the following images
	| Image 	  |
	| image-1.jpg |
And the gadget "g2" belonging to "pbanos" has the following images
	| Image 	  |
	| image-2.jpg |
And the user "other" has as gadgets
	| Name 	|
	| g4	|
	| g5	|
	| g6	|
And the gadget "g4" belonging to "other" has the following images
	| Image 	  |
	| image-3.jpg |
And the gadget "g5" belonging to "other" has the following images
	| Image 	  |
	| image-3.jpg |
When I go to the user page
And I follow "Small cover flow"
Then I should see the following images
	| Image 	  |
	| image-1.jpg |
	| image-2.jpg |
And I should not see image "image-3.jpg"
And all the images should be original-sized

