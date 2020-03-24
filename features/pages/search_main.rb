class SearchMain < SitePrism::Page

	set_url 'https://www.airbnb.com/'

    #Elements on SearchMain
  	element :where, :id, 'Koan-magic-carpet-koan-search-bar__input'
  	element :searchOptionOne, :id, 'Koan-magic-carpet-koan-search-bar__option-0'

  	element :checkIn, :id, 'checkin_input'
  	element :checkOut, :id, 'checkout_input'
    element :nextMonth, :xpath, '//*[contains(@aria-label,"next month")]'

  	element :guestsButton, :id, 'lp-guestpicker'
  	element :adultAddButton, :xpath, '//*[contains(@aria-labelledby,"adults")]//*[@aria-label="add"]'
  	element :childAddButton, :xpath, '//*[contains(@aria-labelledby,"children")]//*[@aria-label="add"]' 
  	element :infantAddButton, :xpath, '//*[contains(@aria-labelledby,"infants")]//*[@aria-label="add"]'

  	element :saveButton, :id, 'filter-panel-save-button'
  	element :searchButton, :xpath, "//span[contains(text(),'Search')]"



    #Functions for elements on SearchMain
  	def enterLocation(location)
    	where.set location
  	end

  	def clickSearchOptionOne
  		searchOptionOne.click
  	end

  	def enterCheckIn(daysToAddString)                                                                      #Interacts with the date widget as a user would and selects date which is current date + 'daysToAddString'                                                                                                           #
      daysToAdd = daysToAddString.split[3].to_i                                                            #Multiple cases handled for all months

  		currentDay = DateTime.now.strftime("%d").to_i
      currentMonth = DateTime.now.strftime("%m").to_i
      currentYear = DateTime.now.strftime("%y").to_i
      currentMonthDays = (Date.new(currentYear, 12, 31) << (12-currentMonth)).day

    	checkInDay = currentDay + daysToAdd
      
      #Leap year's feb
      if currentMonthDays == 29 && checkInDay > 29
        
        checkInDay= checkInDay - 29
        checkIn.click
        nextMonth.click

        if checkInDay <= 9
          page.all("td", :text => checkInDay)[0].click
        elsif checkInDay >= 10
          find("td", :text => checkInDay).click
        end
      
      #Normal year's feb
      elsif currentMonthDays == 28 && checkInDay > 28
        
        checkInDay= checkInDay - 28
        checkIn.click
        nextMonth.click

        if checkInDay <= 9
          page.all("td", :text => checkInDay)[0].click
        elsif checkInDay >= 10
          find("td", :text => checkInDay).click
        end

      elsif currentMonthDays == 30 && checkInDay > 30
        
        checkInDay= checkInDay - 30
        checkIn.click
        nextMonth.click

        if checkInDay <= 9
          page.all("td", :text => checkInDay)[0].click
        elsif checkInDay >= 10
          find("td", :text => checkInDay).click
        end
      
      elsif currentMonthDays == 31 && checkInDay > 31

        checkInDay= checkInDay - 31
        checkIn.click
        nextMonth.click

        if checkInDay <= 9
          page.all("td", :text => checkInDay)[0].click
        elsif checkInDay >= 10
          find("td", :text => checkInDay).click
        end

      elsif checkInDay <= 31
        checkIn.click

        if checkInDay <= 9
          page.all("td", :text => checkInDay)[0].click
        elsif checkInDay >= 10
          find("td", :text => checkInDay).click
        end
      end                                                             
  	end

  	def enterCheckOut(daysToAddString)                                                                    #Interacts with the date widget as a user would and selects date which is current date + 'daysToAddString' 
      daysToAdd = daysToAddString.split[3].to_i                                                           #Multiple cases handled for all months
  		currentDay = DateTime.now.strftime("%d").to_i
      currentMonth = DateTime.now.strftime("%m").to_i
      currentYear = DateTime.now.strftime("%y").to_i
      currentMonthDays = (Date.new(currentYear, 12, 31) << (12-currentMonth)).day

    	checkOutDay = currentDay + daysToAdd

      #Leap year's feb
      if currentMonthDays == 29 && checkOutDay > 29
        
        checkOutDay = checkOutDay - 29
        checkOut.click
        nextMonth.click

        if checkOutDay <= 9
          page.all("td", :text => checkOutDay)[0].click
        elsif checkOutDay >= 10
          find("td", :text => checkOutDay).click
        end
      
      #Normal year's feb
      elsif currentMonthDays == 28 && checkOutDay > 28
        
        checkOutDay = checkOutDay - 28
        checkOut.click
        nextMonth.click

        if checkOutDay <= 9
          page.all("td", :text => checkOutDay)[0].click
        elsif checkOutDay >= 10
          find("td", :text => checkOutDay).click
        end

      elsif currentMonthDays == 30 && checkOutDay > 30

        checkOutDay = checkOutDay - 30
        checkOut.click
        nextMonth.click

        if checkOutDay <= 9
          page.all("td", :text => checkOutDay)[0].click
        elsif checkOutDay >= 10
          find("td", :text => checkOutDay).click
        end

      elsif currentMonthDays == 31 && checkOutDay > 31

        checkOutDay = checkOutDay - 31
        checkOut.click
        nextMonth.click

        if checkOutDay <= 9
          page.all("td", :text => checkOutDay)[0].click
        elsif checkOutDay >= 10
          find("td", :text => checkOutDay).click
        end

      elsif checkOutDay <= 31

        checkOut.click

        if checkOutDay <= 9
          page.all("td", :text => checkOutDay)[0].click
        elsif checkOutDay >= 10
          find("td", :text => checkOutDay).click
        end
      end
    end

  	def addAdults (noOfAdults)                                                                                     #Clicks the '+' for Adults 'noOfAdults' times 
  		guestsButton.click
  		adultLoop =  noOfAdults.to_i
    	adultLoop.times do
    		adultAddButton.click
    	end
    	saveButton.click
  	end

  	def addChildren (noOfChildren)                                                                                 #Clicks the '+' for Children 'noOfChildren' times 
  		guestsButton.click
  		childLoop =  noOfChildren.to_i
    	childLoop.times do
    		childAddButton.click
    	end
    	saveButton.click
  	end

  	def addInfants (noOfInfants)                                                                                   #Clicks the '+' for Infants 'noOfInfants' times 
    	guestsButton.click
    	infantLoop = noOfInfants.to_i
    	infantLoop.times do
      		infantAddButton.click
    	end
    	saveButton.click
  	end

  	def clickSearch
  		searchButton.click
  	end
end
