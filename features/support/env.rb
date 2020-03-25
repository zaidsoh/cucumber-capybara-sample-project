require 'rubygems'
require 'capybara'
require 'capybara/dsl'
require 'rspec'
require 'site_prism'
 
Capybara.run_server = false 
Capybara.default_driver = :selenium
Capybara.ignore_hidden_elements = true 
Capybara.default_max_wait_time = 12
Capybara.exact = true

#Define the driver to be used
Capybara.register_driver :site_prism do |app|
  browser = ENV.fetch('browser', 'chrome').to_sym
  Capybara::Selenium::Driver.new(app, browser: browser)
end

# Then tell Capybara to use the Driver you've just defined as its default driver
Capybara.configure do |config|
  config.default_driver = :site_prism
end

#Maximize browser window after it loads
Capybara.page.driver.browser.manage.window.maximize

#Synchronization related settings
module Helpers
  def without_resynchronize
    page.driver.options[:resynchronize] = false
    yield
    page.driver.options[:resynchronize] = true
  end
end
World(Capybara::DSL, Helpers)