Feature: AIRBNB SEARCH
 
@ BASIC SEARCH
Scenario: Access AIRBNB and perform a basic search

	Given that the user is on airbnb's search page

	When user sets 'WHERE' as 'Rome, Italy'
	* 'CHECK-IN' as 'current date plus 7 days'
	* 'CHECK-OUT' as 'current date plus 14 days'
	* 'Adults' as '2'
	* 'Children' as '1'
	* 'Infants' as '0'
	* clicks 'Search'

	Then 'location' filter should be applied correctly as 'Metropolitan City of Rome · Stays'
	* 'duration' filter should be applied correctly as ''
	* 'guests' filter should be applied correctly as '3 guests'
	* results on the first page should atleast include '3' 'guests'

@ ADVANCED SEARCH
Scenario: Access AIRBNB and perform an advanced search

	Given that the user is on airbnb's search page

	When user sets 'WHERE' as 'Rome, Italy'
	* 'CHECK-IN' as 'current date plus 7 days'
	* 'CHECK-OUT' as 'current date plus 14 days'
	* 'Adults' as '2'
	* 'Children' as '1'
	* 'Infants' as '0'
	* clicks 'Search'
	* clicks 'More filters'
	* 'Bedrooms' as '5'
	* 'Facility' as 'Pool'
	* clicks 'Show Stays'

	Then results on the first page should atleast include '5' 'bedrooms'
	* first property should have 'Pool' under 'Facilities' category

@ MAP INTERACTION
Scenario: Access AIRBNB, perform an advanced search and interact with the map

	Given that the user is on airbnb's search page

	When user sets 'WHERE' as 'Rome, Italy'
	* 'CHECK-IN' as 'current date plus 7 days'
	* 'CHECK-OUT' as 'current date plus 14 days'
	* 'Adults' as '2'
	* 'Children' as '1'
	* 'Infants' as '0'
	* clicks 'Search'
	* hovers over search result '1'

	Then background color changes for the selected result map pill
	* information in the map pop up and search result should match