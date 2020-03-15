# ZAMEEN - Automated tests

Frameworks used: Cucumber, Capybara (scripting language: Ruby) 
Utilized the SitePrism gem for implementing page object model

Folder structure:

|-- features
|   |-- pages
|   |   |-- search_main.rb                         -----> Search main page
|   |   |-- search_results.rb                      -----> Search results page 
|   |   `-- result_details.rb                      -----> Result details page     
|   |-- step_definitions
|   |   `-- test_steps.rb                          -----> Implementation of test definitions
|   |-- support
|   |   `-- env.rb                                 -----> Configuration file
|   `-- search.feature                             -----> Feature file containing test definitions
`-- README.txt
