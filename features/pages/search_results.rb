include RSpec::Matchers

class SearchResults < SitePrism::Page
 
    #Elements on SearchResults
	element :locationString, :id, 'Koan-via-SearchHeader__input'
	element :durationString, :id, 'menuItemButton-date_picker'
	element :guestString, :id, 'menuItemButton-guest_picker'

	element :moreFilters, :id, 'menuItemButton-dynamicMoreFilters'
	element :bedroomAddButton, :xpath, "//*[@id='filterItem-stepper-min_bedrooms-0']//*[contains(@aria-label,'increase value')]"
	element :showStaysButton, :xpath, "//button[contains(text(),'Show')]"
	element :poolCheckbox, :xpath, "//*[contains(text(),'Pool')]"

	element :popUpTitle, :xpath, "//aside//*[contains(text(),'Entire') or contains(text(),'room')]"
	element :popUpName, :xpath, "//aside//*[contains(@style,'ellipsis')]"
	element :popUpPrice, :xpath, "//aside//*[contains(text(),' / night')]"
	element :popUpRating, :xpath, "//aside//*[contains(@aria-label,'Rating')]"


    #Collections of elements with the same selector on SearchResults
	elements :searchResults, :xpath, '//*[contains(@itemprop,"itemListElement")]'
	elements :guestBedStrings, :xpath, "//*[contains(@itemprop,'itemListElement')]//*[contains(text(),'guests')]"

	elements :mapPills, :xpath, "//aside//*[contains(@data-veloute,'map/markers/BasePillMarker')]"

	elements :resultTitles, :xpath, "//*[contains(@itemprop,'itemListElement')]//*[contains(text(),'Entire') or contains(text(),'room')]"
	elements :resultNames, :xpath, "//*[contains(@itemprop,'itemListElement')]//*[contains(@style,'ellipsis')]"
	elements :resultPrices, :xpath, "//*[contains(@itemprop,'itemListElement')]//*[contains(text(),' / night')]"
	elements :resultRatings, :xpath, "//*[contains(@itemprop,'itemListElement')]//*[contains(@aria-label,'Rating')]"

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