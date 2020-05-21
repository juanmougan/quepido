require "watir"
require "spec_helper"
#require "sinatra/config_file"
#require 'yaml'

#config_file '../config/comidas.yml'

describe "QuePido" do
  before do
    #thing = YAML.load_file('../config/comidas.yml')
    #puts "YAML content"
    #puts thing.inspect
    @todas = @clasicas + @etnicas
    puts "todas: #{@todas}"
    goto "http://localhost:4567"
  end
  
  it "gets an ethnic food" do
    etnicas = browser.label id: 'etnicas'
    expect(etnicas).to be_present
    expect(browser.text.include?("Podríamos pedir ")).to be true
    #expect(browser.text.include?(@etnicas)).to be true
    #expect(browser.text).to include(@etnicas)
    chosen = browser.strong class: 'item-chosen'
    puts "chosen.text: #{chosen.text}"
    expect(chosen.text).to any_element_from_list_includes(@etnicas)
  end
end
