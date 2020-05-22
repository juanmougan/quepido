require "watir"
require "spec_helper"

describe "QuePido" do
  before do
    @todas = @clasicas + @etnicas
    goto "http://localhost:4567"
  end
  
  it "gets an ethnic food" do
    # GIVEN page is loaded
    etnicas = browser.label id: 'etnicas'
    expect(etnicas).to be_present
    expect(browser.text.include?("Podríamos pedir ")).to be true

    # WHEN etnicas is clicked
    etnicas.click
    
    # THEN one of the "etnicas" meals is returned
    chosen = browser.strong class: 'item-chosen'
    puts "chosen.text: #{chosen.text}"
    expect(chosen.text).to any_element_from_list_includes(@etnicas)
  end
end
