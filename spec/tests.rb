require 'watir'
require "spec_helper"

describe "QuePido" do
  before { goto "http://localhost:4567" }
  
  it "gets an ethnic food" do
    etnicas = browser.label id: 'etnicas'
    expect(etnicas).to be_present
    expect(browser.text.include?("Podríamos pedir ")).to be true
  end
end
