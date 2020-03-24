include RSpec::Matchers

class SearchDetails < SitePrism::Page
	
	#Elements on SearchDetails	
	element :amenities, :id, 'amenities'
	element :showAmenities, :xpath, "//button[contains(text(),'amenities')]"
	element :poolLabel, :xpath, "//div[contains(@aria-label,'Amenities')]//*[contains(text(),'Pool')]"

	#Functions for elements on SearchMDetails
	def verifyFacility(facilityType)															#Verifies the selected facility to be 'facilityType'
		scroll_to(amenities)
		showAmenities.click

		expect(poolLabel.isPresent?).to be true
		expect(poolLabel.text).to eq facilityType
    end
end