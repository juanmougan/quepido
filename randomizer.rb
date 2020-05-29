class Randomizer
  def initialize(classics, ethnics)
    @classics = classics
    @ethnics = ethnics
    @all = classics + ethnics
  end

  def random_classic_except black_list
    random_element_from(@classics)
  end

  def random_ethnics_except black_list
    random_element_from(@ethnics)
  end

  def random_all_except black_list
    random_element_from(@all)
  end

  def random_element_from(list)
    max_index = Random.rand(list.size - 1)
    list[max_index]
  end
end
