class Randomizer
  def initialize(classics, ethnics)
    @classics = classics
    @ethnics = ethnics
    @all = classics + ethnics
  end

  def random_classic_except black_list
    random_element_from((@classics.to_set - black_list).to_a)
  end

  def random_ethnics_except black_list
    random_element_from((@ethnics.to_set - black_list).to_a)
  end

  def random_all_except black_list
    random_element_from((@all.to_set - black_list).to_a)
  end

  def random_element_from(list)
    if list.empty?
      return ""
    else
      max_index = Random.rand(list.size - 1)
      return list[max_index]
    end
  end
end
