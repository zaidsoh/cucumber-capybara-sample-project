include RSpec::Matchers

class SearchDetails < SitePrism::Page
	
	#Elements on SearchDetails	
	element :showAmenitiesButton, :xpath, "//button[contains(text(),'amenities')]"
	element :poolLabel, :xpath, "//div[contains(@aria-label,'Amenities')]//*[contains(text(),'Pool')]"

    element :detailsName, :xpath, "//div[contains(@itemprop,'name')]"
    element :detailsPrice, :xpath, "(//span[contains(text(),'price')])[1]//parent::div"
    element :detailsRating, :xpath, "(//*[contains(@aria-label,'Rating')])[3]//parent::div"
    element :detailsInfo, :xpath, ''
    element :detailsAddInfo, :xpath, ''    

	#Functions for elements on SearchMDetails
	def initialize 
		@searchResults = SearchResults.new
	end

	def verifyFacility(facilityType)         																		#Verifies the selected facility to be 'facilityType'													
		showAmenitiesButton.click

		page.should have_xpath("//div[contains(@aria-label,'Amenities')]//*[contains(text(),'Pool')]")
		expect(poolLabel.text).to eq facilityType
    end

    def verifyDetailsInfoMatches(hoveredSearchResult)
    	searchResultName = @searchResults.getSearchResultName(hoveredSearchResult)
    	expect(detailsName.text).to eq searchResultName

    	searchResultPrice = @searchResults.getSearchResultPrice(hoveredSearchResult)
    	expect(detailsPrice.text).to eq searchResultPrice

    	searchResultRating = @searchResults.getSearchResultRating(hoveredSearchResult)
    	expect(detailsRating.native.css_value('aria-label')).to eq searchResultRating
    end

end