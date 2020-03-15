include RSpec::Matchers

class SearchResults < SitePrism::Page
 
    #Elements on SearchResults
	element :locationString, :id, 'Koan-via-SearchHeader__input'
	element :durationString, 'div#menuItemButton-date_picker > ._v2ee95z'
	element :guestString, 'div#menuItemButton-guest_picker > ._v2ee95z'

	element :moreFilters, :id, 'menuItemButton-dynamicMoreFilters'
	element :bedroomAddButton, :xpath, '//*[@id="filterItem-stepper-min_bedrooms-0"]/button[2]'
	element :showStaysButton, '._2i58o3a'
	element :popUpName, '._sh35u3h'
	element :popUpPrice, '._o60r27k'

    #Collections of elements with the same selector on SearchResults
	elements :searchResults, '._8ssblpx'
	elements :guestStrings, '._1ulsev2'
	elements :bedroomStrings, '._1ulsev2'
	elements :commonCheckboxes, '._6ioq746'

	elements :mapPills, '._1nq36y92'
	elements :titles, '._4ntfzh'
	elements :names, '._1jbo9b6h'
	elements :prices, '._zkkcbwd'
	elements :ratings, '._60hvkx2'

	#Functions for elements on SearchResults
	def verifyLocationFilter (expectedlocation)																		#Verifies the location filter by comparing expectedLocation with locationString						
		expect(locationString.value).to eq expectedLocation 														#text fetched from the location filter		
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
		expect(guestString.text).to eq expectedNoOfGuests 															#text fetched from the guests filter
	end

	def verifyGuestResults (expectedNoOfGuests)																		#Verifies the number of guests in each search result to be greater than 'expectedNoOfGuests'
		expectedNoOfGuests = expectedNoOfGuests.to_i																#by fetching the guestString from each search result	
		loopCount =  page.all(:css,'._1ulsev2').count
		loopCount = loopCount - 1

		guestStringsArray = guestStrings.map { |guestString| guestString.text }
		
		while loopCount >= 0
			if loopCount%2 ==0
				guestString = guestStringsArray[loopCount]
				guests = guestString.split[0].to_i
				expect(guests >= expectedNoOfGuests).to be true
				loopCount = loopCount - 1
			elsif loopCount%2 != 0
				loopCount = loopCount - 1
			end
		end
	end

	def verifyBedroomResults (expectedNoOfBedrooms)																	#Verifies the number of bedrooms in each search result to be greater than 'expectedNoOfBedrooms'
		expectedNoOfBedrooms = expectedNoOfBedrooms.to_i															#by fetching the bedroomString from each search result
		loopCount =  page.all(:css,'._1ulsev2').count
		loopCount = loopCount - 1

		bedroomStringsArray = bedroomStrings.map { |bedroomString| bedroomString.text }

		while loopCount >= 0
			if loopCount%2 ==0
				bedroomString = bedroomStringsArray[loopCount]
				bedrooms = bedroomString.split[3].to_i
				expect(bedrooms >= expectedNoOfBedrooms).to be true
				loopCount = loopCount - 1
			elsif loopCount%2 != 0
				loopCount = loopCount - 1
			end
		end
	end

	def addBedrooms(noOfBedrooms)																					#Clicks the '+' for Bedrooms 'noOfBedrooms' times 
		bedLoop = noOfBedrooms.to_i
		bedLoop.times do
			bedroomAddButton.click
		end
	end

	def selectFacility(facilityType)																				#Selects the facility as 'facilityType'
		facilitySection = page.find(:css,'._9fvlwj0', :text => 'Facilities')
		if facilityType == 'Pool'
			within (facilitySection) do
				commonCheckboxes[3].click
			end
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

		titlesArray = titles.map { |title| title.text }    	
    	popUpTitle = titlesArray[20]
		resultString = titlesArray[0]
		resultTitle = resultString.split(" Rating")[0]
		expect(popUpTitle).to eq resultTitle

		namesArray = names.map { |name| name.text }        
		popUpName = popUpName
		resultName = namesArray[0]
		expect(popUpName).to eq resultName

		pricesArray = prices.map { |price| price.text }
		popUpPrice = popUpPrice.text
		resultPrice = pricesArray[0]
		expect(popUpPrice).to eq resultPrice

		ratingsArray = ratings.map { |rating| rating.text }	
		popUpRating = ratingsArray[20]
		resultRating = ratingsArray[0]
		expect(popUpRating).to eq resultRating
	end		
end

