include RSpec::Matchers

class SearchResults < SitePrism::Page
 
    #Elements on SearchResults
	element :locationString, :id, 'Koan-via-SearchHeader__input'
	element :durationString, :id, 'menuItemButton-date_picker'
	element :guestString, :id, 'menuItemButton-guest_picker'

	element :moreFilters, :id, 'menuItemButton-dynamicMoreFilters'
	element :bedroomAddButton, :xpath, '//*[@id="filterItem-stepper-min_bedrooms-0"]/button[2]'
	element :showStaysButton, :xpath, '/html/body/div[9]/section/div/div/footer/button'

	element :poolCheckbox, :xpath, "/html/body/div[9]/section/div/div/div[2]/descendant::div[contains(text(),'Pool')]"

	element :popUpTitle, :xpath, '//*[@id="ExploreLayoutController"]/div[2]/div[3]/aside/div/div[1]/div/div/div[1]/div[3]/div/div[4]/div[21]/div/div[1]/div/div[2]/div[1]'
	element :popUpName, :xpath, '//*[@id="ExploreLayoutController"]/div[2]/div[3]/aside/div/div[1]/div/div/div[1]/div[3]/div/div[4]/div[21]/div/div[1]/div/div[2]/div[2]'
	element :popUpPrice, :xpath, '//*[@id="ExploreLayoutController"]/div[2]/div[3]/aside/div/div[1]/div/div/div[1]/div[3]/div/div[4]/div[21]/div/div[1]/div/div[2]/div[3]'
	element :popUpRating, :xpath, '//*[@id="ExploreLayoutController"]/div[2]/div[3]/aside/div/div[1]/div/div/div[1]/div[3]/div/div[4]/div[21]/div/div[1]/div/div[2]/div[4]'


    #Collections of elements with the same selector on SearchResults
	elements :searchResults, :xpath, '//*[@id="ExploreLayoutController"]/div[2]/div[1]/div/div/div[2]/div/div/div/div[2]/div/div/div/div/child::div'
	elements :guestBedStrings, :xpath, "//*[@id='ExploreLayoutController']/div[2]/div[1]/div/div/div[2]/div/div/div/div[2]/div/div/div/div/descendant::div[contains(text(),'guests')]"

	elements :mapPills, :xpath, '//*[@id="ExploreLayoutController"]/div[2]/div[3]/aside/div/div[1]/div/div/div[1]/div[3]/descendant::button'
	elements :resultTitles, :xpath, "//*[@id='ExploreLayoutController']/div[2]/div[1]/div/div/div[2]/div/div/div/div[2]/div/div/div/div/descendant::div[contains(text(),'Entire') or contains(text(),'room')]/parent::div"
	elements :resultNames, :xpath, "//*[@id='ExploreLayoutController']/div[2]/div[1]/div/div/div[2]/div/div/div/div[2]/div/div/div/div/descendant::div[contains(@style,'ellipsis')]"
	elements :resultPrices, :xpath, "//*[@id='ExploreLayoutController']/div[2]/div[1]/div/div/div[2]/div/div/div/div[2]/div/div/div/div/descendant::span[contains(text(),' / night')]/parent::div"
	elements :resultRatings, :xpath, "//*[@id='ExploreLayoutController']/div[2]/div[1]/div/div/div[2]/div/div/div/div[2]/div/div/div/div/descendant::span[contains(text(),'Rating')]/parent::span"

	#Functions for elements on SearchResults
	def verifyLocationFilter (expectedLocation)																	    #Verifies the location filter by comparing expectedLocation with locationString						
		expect(locationString.value).to eq expectedLocation														    #text fetched from the location filter		
	end

	def verifyDurationFilter																						#Verifies the duration filter by calculating the duration using current date
		currentDay = DateTime.now.strftime("%d").to_i																#and comparing it with durationString text fetched from the filter
		checkInDay = currentDay + 7
		checkOutDay = checkInDay + 7

		currentMonthCom = DateTime.now.strftime("%B")
		currentMonth = currentMonthCom[0,3]
		expectedDuration = currentMonth+' '+checkInDay.to_s+' - '+checkOutDay.to_s

		expect(durationString.text).to eq expectedDuration
	end

	def verifyGuestFilter (expectedGuests)																			#Verifies the guests filter by comparing expectedGuests with guestString
		expect(guestString.text).to eq expectedGuests 															    #text fetched from the guests filter
	end

	def verifyGuestResults (expectedNoOfGuests)																		#Verifies the number of guests in each search result to be greater than 'expectedNoOfGuests'
		expectedNoOfGuests = expectedNoOfGuests.to_i																#by fetching the guestString from each search result	
		loopCount =  searchResults.count
		loopCount = loopCount - 1

		guestStringsArray = guestBedStrings.map { |guestBedString| guestBedString.text }
		
		while loopCount >= 0
			guestString = guestStringsArray[loopCount]
			guests = guestString.split[0].to_i
			expect(guests >= expectedNoOfGuests).to be true
			loopCount = loopCount - 1
		end
	end

	def verifyBedroomResults (expectedNoOfBedrooms)																	#Verifies the number of bedrooms in each search result to be greater than 'expectedNoOfBedrooms'
		expectedNoOfBedrooms = expectedNoOfBedrooms.to_i															#by fetching the bedroomString from each search result
		loopCount =  page.all(:css,'._1ulsev2').count
		loopCount = loopCount - 1

		bedroomStringsArray = guestBedStrings.map { |guestBedString| guestBedString.text }

		while loopCount >= 0
			bedroomString = bedroomStringsArray[loopCount]
			bedrooms = bedroomString.split[3].to_i
			expect(bedrooms >= expectedNoOfBedrooms).to be true
			loopCount = loopCount - 1
		end
	end

	def addBedrooms(noOfBedrooms)																					#Clicks the '+' for Bedrooms 'noOfBedrooms' times 
		bedLoop = noOfBedrooms.to_i
		bedLoop.times do
			bedroomAddButton.click
		end
	end

	def selectFacility(facilityType)																				#Selects the facility as 'facilityType'
		if facilityType == 'Pool'
			poolCheckbox.click
		end
	end

	def clickMoreFilters
		moreFilters.click
	end

	def clickShowStays
		showStaysButton.click
	end

	def clickFirstResult
		firstProperty = searchResults[0]
		firstProperty.click
	end

    def hoverSearchResult(base)
    	resultNo = base.to_i - 1
    	firstProperty = searchResults[resultNo]
    	firstProperty.hover
    end

    def verifyPillColor																							#Verifies background color of selected map pill
    	color = mapPills[0].native.css_value('background-color')
    	expect(color).to eq 'rgb(34, 34, 34)'
    end

    def verifyInfoMatches																						#Verifies that the information of first search result and its map pop up matches
    	firstPropertyPill = mapPills[0]
    	firstPropertyPill.click

		resultTitlesArray = resultTitles.map { |resultTitle| resultTitles.text }    	
    	popUpTitle = popUpTitle.text
		resultString = resultTitlesArray[0]
		resultTitle = resultString.split(" Rating")[0]
		expect(popUpTitle).to eq resultTitle

		resultNamesArray = resultNames.map { |resultName| resultName.text }        
		popUpName = popUpName.text
		resultName = resultNamesArray[0]
		expect(popUpName).to eq resultName

		resultsPricesArray = resultsPrices.map { |resultsPrice| resultsPrice.text }
		popUpPrice = popUpPrice.text
		resultPrice = resultsPricesArray[0]
		expect(popUpPrice).to eq resultPrice

		resultRatingsArray = resultRatings.map { |resultRating| resultRating.text }	
		popUpRating = popUpRating.text
		resultRating = resultRatingsArray[0]
		expect(popUpRating).to eq resultRating
	end
end		