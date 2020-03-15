include RSpec::Matchers

class SearchDetails < SitePrism::Page
	
	#Elements on SearchDetails	
	element :amenities, '#amenities'
	element :commonlink, '._b0ybw8s'

	#Functions for elements on SearchMDetails
	def verifyFacility(facilityType)												#Verifies the selected facility to be 'facilityType'
		scroll_to(amenities)
		within (amenities) do
			commonlink.click
		end

		poolText = find(:css,'._czm8crp', :text => facilityType)

		expect(poolText.isPresent?).to be true
		expect(poolText.text).to eq facilityType
    end
end