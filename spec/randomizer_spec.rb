require_relative '../randomizer.rb'

describe Randomizer do
  it 'returns an empty list if all meals were already suggested' do
    # Given a list of meals
    all_classics = ['pizza', 'pastas', 'parrilla']
    # Given a list of already ordered meals
    already_ordered_classics = all_classics
    randomizer = Randomizer.new(all_classics, [])
    # When get another random meal
    meal = randomizer.random_classic
    # Then an meal is returned
    expect(meal).to eq("")
  end
end
