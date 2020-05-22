# Configuration for watir-rspec
require "watir/rspec"
require "yaml"

RSpec.configure do |config|
  # Use Watir::RSpec::HtmlFormatter to get links to the screenshots, html and
  # all other files created during the failing examples.
  config.add_formatter(:progress) if config.formatters.empty?
  config.add_formatter(Watir::RSpec::HtmlFormatter)

  # Open up the browser for each example.
  config.before :all do
    @browser = Watir::Browser.new
    @meals = YAML.load_file(File.expand_path('../config/comidas.yml', File.dirname(__FILE__)))
    @clasicas = @meals["clasicas"]
    @etnicas = @meals["etnicas"]
  end

  # Close that browser after each example.
  config.after :all do
    @browser.close if @browser
  end

  # Include RSpec::Helper into each of your example group for making it possible to
  # write in your examples instead of:
  #   @browser.goto "localhost"
  #   @browser.text_field(name: "first_name").set "Bob"
  #
  # like this:
  #   goto "localhost"
  #   text_field(name: "first_name").set "Bob"
  #
  # This needs that you've used @browser as an instance variable name in
  # before :all block.
  config.include Watir::RSpec::Helper

  # Include RSpec::Matchers into each of your example group for making it possible to
  # use #within with some of RSpec matchers for easier asynchronous testing:
  #   expect(@browser.text_field(name: "first_name")).to exist.within(2)
  #   expect(@browser.text_field(name: "first_name")).to be_present.within(2)
  #   expect(@browser.text_field(name: "first_name")).to be_visible.within(2)
  #
  # You can also use #during to test if something stays the same during the specified period:
  #   expect(@browser.text_field(name: "first_name")).to exist.during(2)
  config.include Watir::RSpec::Matchers

  # My custom matcher
  RSpec::Matchers.define :any_element_from_list_includes do |element_list|
    match do |element_text|
      element_list.collect {|e| element_text.include? e}.reduce(false) {|first, second| first or second}
    end
    failure_message do |element_text|
      "expected that #{element_text} would include any of #{element_list}."
    end
  end  
end
