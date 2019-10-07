require("minitest/autorun")
require("minitest/rg")
require_relative("../animal")

class TestAnimal < Minitest::Test

  def setup
    #create animals
    @animal1 = Animal.new({
      "name" => "Frank",
      "age" => 3,
      "species" => "Cat",
      "admission_date" => "24/05/19",
      "is_adoptable" => true
      })
  end

  def test_update_status
    @animal1.status
    assert_equal(false, @animal1.is_adoptable)
  end

end
