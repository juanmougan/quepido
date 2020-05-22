require "watir"
require "spec_helper"

describe "QuePido" do
  before do
    @todas = @clasicas + @etnicas
    goto "http://localhost:4567"
  end

  it "loads and gets a classic food" do
    # GIVEN page is loaded
    expect_base_text_to_be_present
    # WHEN meal is loaded THEN it is a Classic meal
    expect_chosen_text_to_be_one_of(@clasicas)
  end
  
  it "gets an ethnic meal when etnicas is clicked" do
    # GIVEN page is loaded
    expect_base_text_to_be_present
    etnicas = browser.label id: 'etnicas'
    expect(etnicas).to be_present

    # WHEN etnicas is clicked
    etnicas.click
    
    # THEN one of the "etnicas" meals is returned
    expect_chosen_text_to_be_one_of @etnicas
    # TODO add assertion: not one of Clasicas
  end

  it "gets an classic meal when clasicas is clicked" do
    # GIVEN page is loaded
    expect_base_text_to_be_present
    clasicas = browser.label id: 'clasicas'
    expect(clasicas).to be_present

    # WHEN clasicas is clicked
    clasicas.click
    
    # THEN one of the "clasicas" meals is returned
    expect_chosen_text_to_be_one_of @clasicas
    # TODO add assertion: not one of Etnicas
  end

  it "gets any meal when todas is clicked" do
    # GIVEN page is loaded
    expect_base_text_to_be_present
    todas = browser.label id: 'todas'
    expect(todas).to be_present

    # WHEN todas is clicked
    todas.click
    
    # THEN one of the "todas" meals is returned
    todas = @clasicas + @etnicas
    expect_chosen_text_to_be_one_of todas
  end

  def expect_base_text_to_be_present
    expect(browser.text.include?("Podríamos pedir ")).to be true
  end

  def expect_chosen_text_to_be_one_of(list)
    chosen = browser.strong class: 'item-chosen'
    expect(chosen.text).to any_element_from_list_includes(list)
  end
end
