require_relative '../randomizer.rb'

describe Randomizer do
  it 'does not throw an error when all meals were suggested' do
    # Given an empty list
    list = []
    randomizer = Randomizer.new([], [])
    # When I ask for a random
    element = randomizer.random_element_from(list)
    # Then return an empty String
    expect(element).to eq("")
  end

  it 'returns an empty list if all meals were already suggested' do
    # Given a list of meals
    all_classics = ['pizza', 'pastas', 'parrilla']
    # Given a list of already ordered meals
    already_ordered_classics = all_classics
    randomizer = Randomizer.new(all_classics, [])
    # When get another random meal
    meal = randomizer.random_classic_except already_ordered_classics
    # Then an meal is returned
    expect(meal).to eq("")
  end
end
