Given("that the user is on airbnb's search page") do
  @searchMain = SearchMain.new                                                                      #Initiates page object class 'SearchMain' instance
  @searchMain.load                                                                                  #Loads home page for airbnb
end

When("user sets {string} as {string}") do |string, string2|                                         #Enters location and selects the first search option 
  @searchMain.enterLocation(string2)                                                         
  sleep(1)
  @searchMain.clickSearchOptionOne
end

When("{string} as {string}") do |string, string2|                                                    #Decides input field to interact with based on 'string' 
  if string == 'CHECK-IN'                                                                            #And uses data present in 'string2' to do so
    @searchMain.enterCheckIn(string2)                                                            

  elsif string == 'CHECK-OUT'
    @searchMain.enterCheckOut(string2)

  elsif string == 'Adults'
    @searchMain.addAdults(string2)

  elsif string == 'Children'
    @searchMain.addChildren(string2)

  elsif string == 'Infants'
    @searchMain.addInfants(string2)

  elsif string == 'Bedrooms'
    @searchResults.addBedrooms(string2)

  elsif string == 'Facility'
    @searchResults.selectFacility(string2)
  end 

end

When("clicks {string}") do |string|                                                                 #Decides button to click based on 'string'
  if string == 'Search'                                                                             
    @searchMain.clickSearch                                                                         
  
  elsif string == 'More filters'
    @searchResults = SearchResults.new                                                              #Initiates page object class 'SearchResults' instance for the second scenario 'ADVANCED SEARCH'
    @searchResults.clickMoreFilters

  elsif string == 'Show Stays'
    @searchResults.clickShowStays
  end

end

Then("{string} filter should be applied correctly as {string}") do |string, string2|                #Decides what to verify based on 'string'
  sleep (4)                                                                                         #Verifies filter 'string' to be correctly applied as 'string2'

  if string == 'location'
    @searchResults = SearchResults.new                                                              #Initiates page object class 'SearchResults' instance for the first scenario 'BASIC SEARCH'
    @searchResults.verifyLocationFilter(string2)

  elsif string == 'duration'
    @searchResults.verifyDurationFilter

  elsif string == 'guests'
    @searchResults.verifyGuestFilter(string2)
  end

end

                                               
Then("results on the first page should atleast include {string} {string}") do |string, string2|    #Decides what to verify based on 'string2'
  if string2 == 'guests'                                                                           #Verifies accomodation of more than 'string' guests OR more than 'string' bedrooms in the first 20 search results
    @searchResults.verifyGuestResults(string)                                                      

  elsif string2 == 'bedrooms'
    sleep (4)
    @searchResults.verifyBedroomResults(string)
  end

end

Then("first property should have {string} under {string} category") do |string, string2|          #Decides what to verify on Search
  @searchResults.clickFirstResult

  if string2 == 'Facilities'
    @searchDetails = SearchDetails.new                                                            #Initiates page object class 'SearchDetails'  instance
    @searchDetails.verifyFacility(string)
  end

  session.driver.browser.switch_to.window(page.driver.browser.window_handles.first)
end


When("hovers over search result {string}") do |string|                                            #Hovers over search result number 'string'
  @searchResults = SearchResults.new                                                              #Initiates page object class 'SearchResults' instance for the third scenario 'MAP INTERACTION'
  @searchResults.hoverSearchResult(string)
end

Then("background color changes for the selected result map pill") do                              #Verifies the background color for the map pill of search result #1
  sleep (2)
  @searchResults.verifyPillColor()
end

Then("information in the map pop up and search result should match") do                           #Verifies information on search result #1 and map pop up for search result #1 matches
  @searchResults.verifyInfoMatches
end