include RSpec::Matchers

class SearchDetails < SitePrism::Page
	
	#Elements on SearchDetails	
	element :amenities, :id, 'amenities'
	element :showAmenities, :xpath, '//*[@id="amenities"]/div/div/div/div/section/div[5]'
	element :poolLabel, :xpath, '/html/body/div[9]/div/div/div/div/section/div/section/div[3]/section/div/div[3]/div/div[1]'

	#Functions for elements on SearchMDetails
	def verifyFacility(facilityType)															#Verifies the selected facility to be 'facilityType'
		scroll_to(amenities)
		showAmenities.click

		expect(poolLabel.isPresent?).to be true
		expect(poolLabel.text).to eq facilityType
    end
end